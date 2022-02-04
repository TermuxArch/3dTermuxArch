#!/usr/bin/env sh
# Copyright 2022 (c) by SDRausty, all rights reserved, see LICENSE
# ffmpeg -i "$1" -vn -ar 11025 -ac 2 -ab 192k -f mp3 m11025.mp3
################################################################################
FILE="$(printf '%s' "$1" | tr ' ' '-' )"
FILE="$(printf '%s' "$FILE" | sed 's/--/-/g' )"
FILE="$(printf '%s' "$FILE" | sed 's/--/-/g' )"
ffmpeg -i "$1" -vn -ac 2 -ab 192k -f mp3 "${FILE%.*}".mp3
ffmpeg -i "${FILE%.*}".mp3 -c:v copy -ac 1 "${FILE%.*}"-mono.mp3
# TermuxArch/3dTermuxArch/scripts/tomono.sh FE
