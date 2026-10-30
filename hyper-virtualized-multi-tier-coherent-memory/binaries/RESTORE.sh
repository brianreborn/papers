#!/bin/sh
set -e
cat b85_00 b85_01 b85_02 b85_03 b85_04 b85_05 b85_06 b85_07 b85_08 b85_09 b85_10 b85_11 b85_12 b85_13 b85_14 b85_15 b85_16 b85_17 b85_18 b85_19 b85_20 b85_21 b85_22 b85_23 b85_24 > papers.b85
python3 -c "import base64,pathlib; pathlib.Path('out.tar.xz').write_bytes(base64.b85decode(pathlib.Path('papers.b85').read_text()))"
tar -xJf out.tar.xz
echo Extracted:
ls -la HyperVirtualized_MultiTier_Coherent_Memory_Preliminary_Design.*
