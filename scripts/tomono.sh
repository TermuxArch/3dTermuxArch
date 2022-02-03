#!/usr/bin/env sh
# Copyright 2022 (c) by SDRausty, all rights reserved, see LICENSE
# ffmpeg -i "$1" -vn -ar 11025 -ac 2 -ab 192k -f mp3 "$TMPDIR"/audio3.mp3
################################################################################
FILE="$(tr ' ' '-' <<< $1)"
FILE="$(sed 's/--/-/g' <<< $FILE)"
FILE="$(sed 's/--/-/g' <<< $FILE)"
ffmpeg -i "$1" -vn -ac 2 -ab 192k -f mp3 "$TMPDIR"/audio3.mp3
ffmpeg -i "$TMPDIR"/audio3.mp3 -c:v copy -ac 1 "$TMPDIR"/mono-output.mp3 && rm -f "$TMPDIR"/audio3.mp3
mv "$TMPDIR"/mono-output.mp3 ${FILE%.*}-mono.mp3
# TermuxArch/3dTermuxArch/scripts/tomono.sh FE
