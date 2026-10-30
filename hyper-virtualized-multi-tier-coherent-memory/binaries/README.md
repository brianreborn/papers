# PDF and DOCX companions

Archive format: **xz (LZMA2)** — same compression family as 7-Zip’s default method.  
**Not** DEFLATE / gzip / LZ77-style zip deflate.

Encoding: base64, split into `part_00` … `part_07` for transport.

## Restore

```bash
cd binaries
sh RESTORE.sh
```

Or manually:

```bash
cat part_00 part_01 part_02 part_03 part_04 part_05 part_06 part_07 > papers_binaries.tar.xz.b64
base64 -d papers_binaries.tar.xz.b64 | tar -xJf -
```

Yields:

- `HyperVirtualized_MultiTier_Coherent_Memory_Preliminary_Design.pdf`
- `HyperVirtualized_MultiTier_Coherent_Memory_Preliminary_Design.docx`
