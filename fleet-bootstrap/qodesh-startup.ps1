# qodesh-startup.ps1 - one-shot bootstrap with backoff guard. Run as Administrator.
function Write-Info   { param($m) Write-Host ("[INFO]  " + $m) -ForegroundColor Cyan }
function Write-Ok     { param($m) Write-Host ("[OK]    " + $m) -ForegroundColor Green }
function Write-ErrorM { param($m) Write-Host ("[ERROR] " + $m) -ForegroundColor Red }

$isWin = $IsWindows -or ($env:OS -eq "Windows_NT")
if (-not $isWin) { Write-ErrorM "Windows OS required"; exit 1 }
Write-Info "Starting qodesh bootstrap."

# Check state for spinloop protection
$stateFile = "C:\LocalAI\.qodesh_state.json"
$state = @{ Failures = 0; LastRun = (Get-Date) }
if (Test-Path -LiteralPath $stateFile) {
    try {
        $s = Get-Content -LiteralPath $stateFile -Raw | ConvertFrom-Json
        if ($s.LastRun -and ((Get-Date) - [DateTime]$s.LastRun).TotalMinutes -lt 10) {
            $state.Failures = $s.Failures
        }
    } catch {}
}

if ($state.Failures -ge 3) {
    Write-ErrorM "Spinloop guard active: 3 consecutive failures in the last 10 minutes. Aborting to protect resources."
    exit 1
}

# 1 - kill stray processes
Get-Process -Name llama-server,node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# 2 - validate manifest
$manifestPath = "C:\LocalAI\android-pack\grz-termux\config\agents.windows.json"
if (-not (Test-Path -LiteralPath $manifestPath)) { Write-ErrorM "Manifest missing"; exit 1 }
try {
    $m = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    $ports = @()
    foreach ($a in $m.agents) {
        if (-not $a.alias) { throw "Agent missing alias" }
        if ($a.port) { $ports += [int]$a.port }
    }
    if ($ports.Count -ne ($ports | Sort-Object -Unique).Count) { throw "Duplicate ports" }
    Write-Ok "Manifest valid."
} catch {
    $state.Failures += 1
    [IO.File]::WriteAllText($stateFile, ($state | ConvertTo-Json), [System.Text.UTF8Encoding]($false))
    Write-ErrorM ("Manifest error: " + $_); exit 1
}

# 3 - launch backend
$backend = "C:\LocalAI\native-engines.ps1"
if (-not (Test-Path -LiteralPath $backend)) { Write-ErrorM "Backend not found"; exit 1 }
Write-Info "Launching backend..."
& $backend
if ($LASTEXITCODE -ne 0) {
    $state.Failures += 1
    [IO.File]::WriteAllText($stateFile, ($state | ConvertTo-Json), [System.Text.UTF8Encoding]($false))
    Write-ErrorM ("Backend failed: " + $LASTEXITCODE); exit 1
}
Start-Sleep -Seconds 2

# 4 - launch gateway
$gw = "C:\LocalAI\android-pack\grz-termux\src\gateway.mjs"
$gwDir = "C:\LocalAI\android-pack\grz-termux"
if (-not (Test-Path -LiteralPath $gw)) { Write-ErrorM "Gateway not found"; exit 1 }
Write-Info "Launching gateway..."
$gwJob = Start-Job -Name QodeshGateway -ScriptBlock {
    param($dir, $entry)
    Set-Location -LiteralPath $dir
    node $entry
} -ArgumentList $gwDir, $gw
Start-Sleep -Seconds 3

# 5 - health check
$url = "http://127.0.0.1:8080/v1/models"
try { $r = Invoke-RestMethod -Uri $url -Method GET } catch { $r = $null }
if ($r -and $r.object -eq "list") {
    Write-Ok ("Gateway OK - " + $r.data.Count + " agents.")
    $state.Failures = 0 # Reset on success
    [IO.File]::WriteAllText($stateFile, ($state | ConvertTo-Json), [System.Text.UTF8Encoding]($false))
} else {
    Write-ErrorM "Gateway not responding."
    Get-Job -Name QodeshGateway -ErrorAction SilentlyContinue | Stop-Job -Force
    $state.Failures += 1
    [IO.File]::WriteAllText($stateFile, ($state | ConvertTo-Json), [System.Text.UTF8Encoding]($false))
    exit 1
}

# 6 - hourly scheduled task
$task = "QodeshAutoHeal"
Get-ScheduledTask -TaskName $task -ErrorAction SilentlyContinue |
    Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue
$sp = $MyInvocation.MyCommand.Path
$ta = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument ("-NoProfile -ExecutionPolicy Bypass -File `"" + $sp + "`"")
$tr = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) `
    -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration ([TimeSpan]::MaxValue)
$pr = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" `
    -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName $task -Action $ta -Trigger $tr -Principal $pr `
    -Description "Hourly self-heal" -ErrorAction SilentlyContinue | Out-Null
Write-Ok ("Task " + $task + " registered.")
Write-Info "Bootstrap complete."