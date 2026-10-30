# PDF + DOCX companions

Compressed with **xz (LZMA2)** (7-Zip family, not DEFLATE).
Encoded with **base85** (~25% overhead vs base64’s ~33%).
Split into `b85_00` … `b85_24` for the text API.

## Restore (one command)

```bash
cd hyper-virtualized-multi-tier-coherent-memory/binaries
sh RESTORE.sh
```

Produces the PDF and DOCX next to the script.
