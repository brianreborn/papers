# parallel-fleet-bootstrap.ps1 - Persistent Multi-Agent Parallel Orchestrator with Hysteresis
# Run as Administrator. Non-interactive execution. Avoids tight restart spin-loops.

function Write-Log { param($m, $color="Cyan") Write-Host ("[PARALLEL] " + $m) -ForegroundColor $color }

$isWin = $IsWindows -or ($env:OS -eq "Windows_NT")
if (-not $isWin) { Write-Log "Windows OS required." "Red"; exit 1 }

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigFile = Join-Path $ScriptDir "agents-bootstrap.json"
$StateFile  = Join-Path $ScriptDir ".fleet_state.json"

if (-not (Test-Path -LiteralPath $ConfigFile)) {
    Write-Log ("Configuration missing: " + $ConfigFile) "Red"
    exit 1
}

$Hostname = $env:COMPUTERNAME
Write-Log ("Host identified as: " + $Hostname) "Green"

$Manifest = Get-Content -LiteralPath $ConfigFile -Raw | ConvertFrom-Json
$Agents = $Manifest.agents
$MaxRetries = if ($Manifest.maxRetriesPerWindow) { $Manifest.maxRetriesPerWindow } else { 3 }
$WindowMinutes = if ($Manifest.windowMinutes) { $Manifest.windowMinutes } else { 10 }

# --- State Management for Hysteresis ---
$State = @{}
if (Test-Path -LiteralPath $StateFile) {
    try {
        $rawState = Get-Content -LiteralPath $StateFile -Raw | ConvertFrom-Json
        foreach ($p in $rawState.PSObject.Properties) {
            $State[$p.Name] = @{
                Failures = $p.Value.Failures
                LastFailure = [DateTime]$p.Value.LastFailure
                InCooldown = $p.Value.InCooldown
            }
        }
    } catch { Write-Log "Initializing new state file." "Yellow" }
}

function Save-State {
    try {
        $json = $State | ConvertTo-Json -Depth 3
        [IO.File]::WriteAllText($StateFile, $json, [System.Text.UTF8Encoding]($false))
    } catch {}
}

function Test-CircuitBreaker {
    param($agentName)
    if (-not $State.ContainsKey($agentName)) {
        $State[$agentName] = @{ Failures = 0; LastFailure = [DateTime]::MinValue; InCooldown = $false }
    }
    $aState = $State[$agentName]
    
    if ($aState.LastFailure -and ((Get-Date) - $aState.LastFailure).TotalMinutes -gt $WindowMinutes) {
        $aState.Failures = 0
        $aState.InCooldown = $false
    }
    
    if ($aState.Failures -ge $MaxRetries) {
        $aState.InCooldown = $true
        Save-State
        Write-Log ("CIRCUIT BREAKER ACTIVE for agent: " + $agentName + ". Too many failures (" + $aState.Failures + "). Cooldown enforced to prevent credit drain.") "Red"
        return $false
    }
    return $true
}

function Record-Failure {
    param($agentName)
    if (-not $State.ContainsKey($agentName)) {
        $State[$agentName] = @{ Failures = 0; LastFailure = (Get-Date); InCooldown = $false }
    }
    $State[$agentName].Failures += 1
    $State[$agentName].LastFailure = (Get-Date)
    Save-State
    Write-Log ("Recorded failure for " + $agentName + " (Count: " + $State[$agentName].Failures + "/" + $MaxRetries + ")") "Yellow"
}

function Resolve-Token {
    param($TokenEnv, $TokenFileTemplate)
    if ($TokenEnv -and (Test-Path "Env:$TokenEnv")) {
        return (Get-Item "Env:$TokenEnv").Value
    }
    if ($TokenFileTemplate) {
        $filePath = $TokenFileTemplate.Replace("%HOSTNAME%", $Hostname)
        if (Test-Path -LiteralPath $filePath) {
            return (Get-Content -LiteralPath $filePath -Raw).Trim()
        }
    }
    return $null
}

function Start-PersistentAgent {
    param($agent)
    if (-not (Test-CircuitBreaker $agent.name)) {
        return $false
    }

    Write-Log ("Spawning persistent background process for: " + $agent.name + " (port " + $agent.port + ")") "Cyan"

    # Security Fix: Isolate environment variables to prevent leaking tokens between agents
    $token = Resolve-Token $agent.tokenEnv $agent.tokenFile
    $originalEnv = $null
    if ($token -and $agent.tokenEnv) {
        if (Test-Path "Env:$($agent.tokenEnv)") {
            $originalEnv = (Get-Item "Env:$($agent.tokenEnv)").Value
        }
        Set-Item -Path ("Env:" + $agent.tokenEnv) -Value $token
    }

    try {
        if ($agent.node) {
            $workDir = if ($agent.cwd) { $agent.cwd } else { Split-Path -Parent $agent.script }
            $argsArray = @($agent.script) + @($agent.args)
            Start-Process -FilePath "node.exe" -ArgumentList $argsArray -WorkingDirectory $workDir -WindowStyle Hidden
        } elseif ($agent.script.EndsWith(".ps1")) {
            $workDir = if ($agent.cwd) { $agent.cwd } else { Split-Path -Parent $agent.script }
            $argsArray = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $agent.script) + @($agent.args)
            Start-Process -FilePath "powershell.exe" -ArgumentList $argsArray -WorkingDirectory $workDir -WindowStyle Hidden
        } else {
            $workDir = if ($agent.cwd) { $agent.cwd } else { Split-Path -Parent $agent.script }
            Start-Process -FilePath $agent.script -ArgumentList $agent.args -WorkingDirectory $workDir -WindowStyle Hidden
        }
    } finally {
        # Restore or remove the environment variable to avoid leaking to the next process spawn
        if ($token -and $agent.tokenEnv) {
            if ($originalEnv -ne $null) {
                Set-Item -Path ("Env:" + $agent.tokenEnv) -Value $originalEnv
            } else {
                Remove-Item -Path ("Env:" + $agent.tokenEnv)
            }
        }
    }
    
    return $true
}

Write-Log "Cleaning up stray llama-server and node processes..." "Yellow"
Get-Process -Name llama-server, node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# Only kill agy processes that are running as the server (avoid killing the main CLI loop)
try {
    Get-CimInstance Win32_Process -Filter "Name='agy.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -match "server" } | ForEach-Object {
        Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
    }
} catch { }

foreach ($agent in $Agents) {
    if (Test-Path -LiteralPath $agent.script) {
        Start-PersistentAgent $agent | Out-Null
    } else {
        Write-Log ("Skipping agent " + $agent.name + " - script not found: " + $agent.script) "Yellow"
    }
}

function Quick-HealthCheck {
    param($port)
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $iar = $client.BeginConnect("127.0.0.1", $port, $null, $null)
        $success = $iar.AsyncWaitHandle.WaitOne(1000, $false)
        if ($success) {
            $client.EndConnect($iar)
            $client.Close()
            return $true
        }
        $client.Close()
        return $false
    } catch { return $false }
}

Write-Log "Waiting for services to listen on configured ports..." "Cyan"
foreach ($agent in $Agents) {
    if ($agent.port) {
        $ready = $false
        for ($i = 0; $i -lt 5; $i++) {
            if (Quick-HealthCheck $agent.port) { $ready = $true; break }
            Start-Sleep -Seconds 3
        }
        if ($ready) {
            Write-Log ("Agent " + $agent.name + " listening on port " + $agent.port) "Green"
        } else {
            Write-Log ("Agent " + $agent.name + " health check failed/timed out on port " + $agent.port) "Red"
            Record-Failure $agent.name
        }
    }
}

$task = "ParallelFleetBootstrap"
Get-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue
$sp = $MyInvocation.MyCommand.Path
$ta = New-ScheduledTaskAction -Execute "powershell.exe" -Argument ("-NoProfile -ExecutionPolicy Bypass -File `"" + $sp + "`"")
$tr = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration ([TimeSpan]::MaxValue)
$pr = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName $task -Action $ta -Trigger $tr -Principal $pr -Description "Hourly persistent parallel fleet auto-heal" -ErrorAction SilentlyContinue | Out-Null
Write-Log ("Installed scheduled task: " + $task) "Green"
Write-Log "Parallel bootstrap initialization finished." "Green"