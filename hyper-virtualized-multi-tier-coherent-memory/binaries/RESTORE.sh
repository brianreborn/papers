#!/bin/sh
# Reconstruct and extract PDF + DOCX
set -e
cat part_00 part_01 part_02 part_03 part_04 part_05 part_06 part_07 > papers_binaries.tar.xz.b64
base64 -d papers_binaries.tar.xz.b64 | tar -xJf -
echo "Extracted:"
ls -la HyperVirtualized_MultiTier_Coherent_Memory_Preliminary_Design.*
