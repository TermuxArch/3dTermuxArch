#!/usr/bin/env bash
## Copyright 2022 by TermuxArch, all rights reserved, please see LICENSE 🌎 🌍 🌏
## The command 'wait an event' is derived from the theories of grey music cognition and music as medicine.  Termux group discussions circa 2018 at Termux community channels were very helpful before the SDRausty account was banned by Termux curators doing the work of open source code squatters.  Please reference https://github.com/SDRausty/builtAPKs/issues/2 for more information about open source code squatting.

## snooze time = time between each play in seconds

## SYNTAX: 'wae [audio files] [audio files] [min snooze time] [max snooze time]'

## USAGE: 'wae *.mp3 path/file.mp4 16 256' plays sound files and waits from 16 to 256 seconds between each play.  Multiple Termux sessions can be used in order to run commands 'wae arguments' simultaneously and to switch seamlessly between plays.
##############################################################################
set -eu
ARG0="${0##*/}"
[ "${1:-}" != "" ] && { { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] || [[ "${1//-}" = [Vv] ]] || [[ "${1//-}" = [Vv][Ee] ]] || [[ "${1//-}" = [Vv][Ee][Rr] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo][Nn] ]] ; } && { printf '\e[0;32m%s\e[0;31m  EXITING...\e[0m\n' "${ARG0^^} INFO cat $0;" && cat "$0" ; exit ; } ; }
[ "${1:-}" != "" ] && { { [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] ; } && { TMPCMD="$(sed -n '2,9p' $0 | sed 's/##\ //g')" && printf '\e[0;32m%s\e[0m\n' "${ARG0^^} HELP $TMPCMD" ; exit ; } ; }
for TMPVRBL in "$@"
do
[[ "$TMPVRBL" =~ ^[0-9]+$ ]] || SNGS+=("$TMPVRBL" )
{ [[ "$TMPVRBL" =~ ^[0-9]+$ ]] && { { [[ -z "${ARG2:-}" ]] && ARG2="$TMPVRBL" ; } || { [[ -z "${ARG3:-}" ]] && ARG3="$TMPVRBL" ; } ; } ; }
done
ARG2="${ARG2:-32}"
ARG3="${ARG3:-512}"
[[ "$ARG2" -lt "$ARG3" ]] || { printf '\e[0;33m%s\e[0;31mEXITING...\e[0m\n' "${ARG0^^} SIGNAL the first numerical argument must be less than the second numerical argument provided;  " && exit ; }
_DPLY_(){
printf '\e[2K\r%s' "Playing '${TRCK##*/}'..."
play-audio "$TRCK" || printf '\e[0;33m%s\e[0;32mCONTINUING...\e[0m\n' "${ARG0^^} SIGNAL play-audio $TRCK;  "
read -n 1 -rs -t 0.01 INPUT && { [[ $INPUT = [Aa] ]] || [[ $INPUT = [Ee] ]] || [[ $INPUT = [Ss] ]] || [[ $INPUT = [Qq] ]] ; } && printf '\n\e[0;32m%s\e[0;31mEXITING...\e[0m\n' "${ARG0^^} INFO keypress $INPUT was detected;  " && exit
SHFNNT="$(shuf -n 1 -i "$ARG2"-"$ARG3")"
printf '\e[2K\r\e[0;32m%s\e[0m' "${ARG0^^} INFO snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
}
_PLYD_(){
TMPCMD="am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null"
{ $TMPCMD && printf '\e[0;32m%sCONTINUING...\e[0m\n' "${ARG0^^} INFO $TMPCMD;  " ; } || printf '\e[0;33m%s\e[0;32mCONTINUING...\e[0m\n' "${ARG0^^} SIGNAL $TMPCMD;  "
while :
do
for TRCK in "${SNGS[@]}"
do
_DPLY_
done
done
}
{ [[ -z "${SNGS[@]}" ]] && printf '\e[0;33m%s\e[0;31mEXITING...\e[0m\n' "${ARG0^^} SIGNAL no file name was given;  " && exit ; } || _PLYD_
# wae.bash EF
