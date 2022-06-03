#!/usr/bin/env sh
# Copyright 2022 (c) by SDRausty, all rights reserved, see LICENSE
# Converts video and music files into mp3 audio format.
################################################################################
set -eu
printf '%s\n' "${0##*/} begun"
[ -x /usr/bin/ffmpeg ] || { pc ffmpeg || pci ffmpeg ; } || _PRNTMESG_ 200
[ -n "${1:-}" ] || { printf '%s\n' "Please enter a file name;  Exiting..." ; exit 69 ; }
if [ ! -d audio/stereo ] || [ ! -d audio/mono ] || [ ! -d audio/mono22050 ] || [ ! -d audio/mono11025 ]
then
mkdir -p audio/stereo audio/mono audio/mono22050 audio/mono11025
fi
_PRNTMESG_ () { printf '%s\n' "Signal $1 received via ${0##*/};  Continuing..." ; }
# create mp3 file name based on input file name
FILE="$(printf '%s' "$1" | tr "'" '-')"
FILE="$(printf '%s' "$FILE" | sed 's/ft\./ft/g' )"
FILE="$(printf '%s' "$FILE" | tr ' ' '-' )"
FILE="$(printf '%s' "$FILE" | tr '(' '-' )"
FILE="$(printf '%s' "$FILE" | tr ')' '-' )"
FILE="$(printf '%s' "$FILE" | tr "[" '-')"
FILE="$(printf '%s' "$FILE" | tr ']' '-' )"
FILE="$(printf '%s' "$FILE" | tr '{' '-' )"
FILE="$(printf '%s' "$FILE" | tr '}' '-' )"
FILE="$(printf '%s' "$FILE" | tr '_' '-' )"
FILE="$(printf '%s' "$FILE" | sed 's/official//i' )" # case insensitive
FILE="$(printf '%s' "$FILE" | sed 's/please-read-description//i' )" # case insensitive
FILE="$(printf '%s' "$FILE" | sed 's/video//i' )" # case insensitive
FILE="$(printf '%s' "$FILE" | sed 's/--/-/g' )"
FILE="$(printf '%s' "$FILE" | sed 's/--/-/g' )"
FILE="$(printf '%s' "$FILE" | sed 's/--/-/g' )"
ffmpeg -i "$1" -vn -ac 2 -ab 192k -f mp3 audio/stereo/"${FILE%.*}".mp3 || _PRNTMESG_ 202
ffmpeg -i audio/stereo/"${FILE%.*}".mp3 -c:v copy -ac 1 audio/mono/"${FILE%.*}"-mono.mp3 || _PRNTMESG_ 204
ffmpeg -i audio/mono/"${FILE%.*}"-mono.mp3 -vn -ar 22050 audio/mono22050/"${FILE%.*}"-m22050.mp3 || _PRNTMESG_ 206
ffmpeg -i audio/mono/"${FILE%.*}"-mono.mp3 -vn -ar 11025 audio/mono11025/"${FILE%.*}"-m11025.mp3 || _PRNTMESG_ 208
printf '%s\n' "${0##*/} done"
# TermuxArch/3dTermuxArch/scripts/cvrt2mp3.sh FE
