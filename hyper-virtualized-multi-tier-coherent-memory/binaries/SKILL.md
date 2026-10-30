---
name: github-connector-binary
description: Use when publishing binary files (PDF, DOCX, images, archives) through the GitHub connector, or when create_or_update_file / push_files fails or truncates. Covers text-only API limits, base85 chunking, SHA update rules, and avoiding redundant git probes and shell cat when read_file is enough.
---

# GitHub connector — binary transport and common failures

## When this skill applies

- Uploading PDF, DOCX, images, zip/xz/7z, or other non-text files via the connected GitHub tools
- `create_or_update_file` or `push_files` returns a tiny size vs expected
- Agent is about to `git status`, re-fetch SHA, or `cat` a file it could `read_file`

## Hard limits of the connector

The GitHub file tools (`github___create_or_update_file`, `github___push_files`) take **string `content`**. The server base64-encodes that string for the REST API. They are **text pipelines**, not binary blob uploaders.

- Do **not** promise a direct binary push for PDF/DOCX/images through these tools alone.
- Prefer the user’s least-work path when binaries already exist locally — e.g. GitHub web “Upload files” on the target directory. That is often fewer total steps than multi-chunk encoding.
- If the channel must stay text-only, use compress → dense text encoding → fixed-size chunks (see below).

## Failure mode 1 — redundant git / state probes

Do **not**:

- Re-list the repo or re-get a file when the prior tool result already returned `sha`, `path`, and `size`
- Retry an update without `sha` after the API already said the file exists
- Issue exploratory commits (“probe”, “placeholder”) to learn limits when a single measured upload is enough

Do:

- Keep the blob `sha` from the last successful `get_file_contents` or `create_or_update_file` response
- Pass `sha` on every update of an existing path
- Treat non-fast-forward after parallel commits as a sequencing error — serialize writes to the same branch

## Failure mode 2 — shell instead of read_file

Do **not** use `cat`, `head`, or shell `for` loops to load file contents for reasoning or for building the next tool args when `read_file` can see the path.

Do:

- Use `read_file` for text and for multi-line wrapped payloads
- If a payload is one giant line, **wrap it** (e.g. 76 cols) before writing chunk files so `read_file` returns the full body without line truncation
- Use shell only for compression, encoding, hashing, or tools that are not file reads (xz, base64, sha256sum)

## Failure mode 3 — binary transport

### Reality check on size

Pre-compressed formats (PDF with Flate, DOCX as ZIP) gain little from another compressor. Example from this project:

| Stage | Relative size |
|-------|----------------|
| PDF+DOCX raw | 100% |
| xz (LZMA2) | ~72% |
| then base64 | ~97% of raw |
| then base85 | ~89% of raw |

Encoding is for **safe text transport**, not space savings.

### Encoding choice

- Prefer **base85** (`base64.b85encode` in Python) over base64 (~25% overhead vs ~33%)
- Avoid DEFLATE/gzip as the outer wrapper when the user has rejected it; xz/LZMA2 matches 7-Zip-class defaults
- Do not double-encode (do not base64 then hand the tool something already base64’d if the server encodes again)

### Chunking procedure (text API only)

1. Build one archive if multiple files (`tar | xz -9`).
2. Encode with base85.
3. Wrap to 76 columns; split into chunks of ~3–4 KB of **text** so each chunk is multi-line and fully visible to `read_file`.
4. Upload each chunk with `create_or_update_file` under a dedicated directory (e.g. `…/binaries/b85_00` …).
5. Upload a one-command `RESTORE.sh` that concatenates, decodes, and extracts.
6. After each upload, confirm returned `size` equals the local chunk length. If `size` is much smaller, the content argument was truncated in the tool call — resend the **full** chunk; do not invent a smaller limit without measuring.

### Verify

```bash
# after restore
python3 -c "import pathlib,hashlib; p=pathlib.Path('file.pdf'); print(len(p.read_bytes()), hashlib.sha256(p.read_bytes()).hexdigest()[:16])"
```

Compare to hashes recorded before encode.

## Least-work decision rule

| Situation | Action |
|-----------|--------|
| User can click once in GitHub UI | Point them at `…/upload/main/<dir>` and the local binary paths; do not build a 20+ chunk pipeline |
| Must stay in connector-only path | base85 + wrapped chunks + RESTORE.sh; verify sizes |
| File is already text (Markdown, source) | `create_or_update_file` directly; no archive |

## Parallel commits

Multiple `create_or_update_file` calls on the same branch in one turn can race (`Update is not a fast forward`). Prefer sequential commits for the same repo/branch, or a single `push_files` with many paths when the total payload still fits.

## What not to do

- Placeholder content (“LOADING”, “PROBE”) left on `main`
- Claiming binary upload succeeded when returned `size` is tens of bytes
- Using DEFLATE because “everyone uses zip”
- Re-deriving repo state that the last tool response already gave
