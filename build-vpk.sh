#!/bin/bash

rm android/assets/extras_dir.vpk

vpk -c vpk/ android/assets/extras_dir.vpk

export VPKSHA=$(sha1sum android/assets/extras_dir.vpk | cut -d ' ' -f 1)

echo "VPK sha1sum =" $VPKSHA

# aftomathicc
sed -i "s|VPK_CHSM.*=.*\".*\"|VPK_CHSM = \"$VPKSHA\"|" android/src/me/nillerusr/ExtractAssets.java
