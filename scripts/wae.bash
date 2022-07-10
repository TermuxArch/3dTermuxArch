#!/usr/bin/env bash
################################################################################
## Copyright 2022 by TermuxArch, all rights reserved, please see LICENSE 🌎 🌍 🌏

## The command 'wait an event' is derived from the theories of grey music cognition and music as medicine.  Termux group discussions circa 2018 at Termux community channels were very helpful before the SDRausty account was banned by Termux curators doing the work of open source code squatters.  Please reference https://github.com/SDRausty/builtAPKs/issues/2 for more information about open source code squatting.

## 	snooze time = time between each play in seconds

## INVOCATIONS:
## 	wae c[at]			print this file on standard output
## 	wae h[elp]			show the help screen
## 	wae *.mp3 path/*.mp3 8 32	play sound files and wait from eight to thirty two seconds between each play
## 	wae file.mp3			play one sound file continually using default snooze time to pause between each play

## OPTIONS WHILE PLAYING:
## 	b[reak]		break at end of play or snooze
## 	CTRL+\		immediately quit current task
## 	CTRL+C		terminate wae session immediately
## 	e[xit]		exit at end of either play or snooze
## 	h[elp]		print help screen at end of current task
## 	q[uit]		quit at end of either play or snooze

## SYNTAX  wae audio_file[s] [audio files] [min snooze time] [max snooze time]

## Variables STMN=32 and STMX=512 can be edited in order to set the default minimum and maximum snooze times.  Please see 'wae cat' for more information.

## Multiple sessions can be used in order to run commands 'wae arguments' simultaneously and to switch seamlessly between plays.
################################################################################
set -eu
FLNM="${0##*/}"
STMN=32
STMX=512
[ "${1:-}" != "" ] && { { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] || [[ "${1//-}" = [Vv] ]] || [[ "${1//-}" = [Vv][Ee] ]] || [[ "${1//-}" = [Vv][Ee][Rr] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo] ]] || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo][Nn] ]] ; } && { printf '\e[0;32m%s\e[0;31m  EXITING...\e[0m\n' "${FLNM^^} INFO cat $0;" && cat "$0" ; exit ; } ; }
_SHWHLP_() { TMPCMD="$(sed -n '3,27p' $0 | sed 's/##\ //g')" && printf '\e[0;32m%s\e[0m\n' "${FLNM^^} HELP $TMPCMD" ; }
[ "${1:-}" != "" ] && { { [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] ; } && _SHWHLP_ && exit ; }

for TMPVRBL in "$@"
do
[[ "$TMPVRBL" =~ ^[0-9]+$ ]] || SNGS+=("$TMPVRBL" )
{ [[ "$TMPVRBL" =~ ^[0-9]+$ ]] && { { [[ -z "${FRSTNM:-}" ]] && FRSTNM="$TMPVRBL" ; } || { [[ -z "${SCNDNM:-}" ]] && SCNDNM="$TMPVRBL" ; } ; } ; }
done

FRSTNM="${FRSTNM:-$STMN}"
SCNDNM="${SCNDNM:-$STMX}"
{ { [[ -n "${SCNDNM:-}" ]] && [[ "$FRSTNM" -le "$STMN" ]] ; } || { FRSTNM="$FRSTNM" && SCNDNM="$STMN" ; } ; }
{ {  [[ -n "${SCNDNM:-}" ]] && [[ "$FRSTNM" -le "$STMX" ]] ; } || { SCNDNM="$FRSTNM" && FRSTNM="$STMN" ; } ; }
[[ "$FRSTNM" -lt "$SCNDNM" ]] || { RSRVNM="$FRSTNM" && FRSTNM="$SCNDNM" && SCNDNM="$RSRVNM" ; }

_DPLY_(){
printf '\e[2K\r%s' "Playing '${TRCK##*/}'..."
play-audio "$TRCK" || printf '\e[0;33m%s\e[0;32mCONTINUING...\e[0m\n' "${FLNM^^} NOTICE play-audio $TRCK;  "
}

_DSLP_(){
SHFNNT="$(shuf -n 1 -i "$FRSTNM"-"$SCNDNM")"
printf '\e[2K\r\e[0;32m%s\e[0m' "${FLNM^^} INFO snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}" || { printf '\e[2K\r\e[0;33m%s\e[0;32mCONTINUING...\e[0m' "${FLNM^^} NOTICE not snoozing for ${SHFNNT:-24} seconds;  Snoozing for four seconds;  " && sleep 4 ; }
}

_PLYD_(){
TMPCMD="am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null"
{ $TMPCMD && printf '\e[0;32m%sCONTINUING...\e[0m\n' "${FLNM^^} INFO $TMPCMD;  " ; } || printf '\e[0;33m%s\e[0;32mCONTINUING...\e[0m\n' "${FLNM^^} NOTICE $TMPCMD;  "
while :
do
{ read -n 1 -rs -t 0.01 INPUT && { { [[ $INPUT = [Aa]* ]] || [[ $INPUT = [Ee]* ]] || [[ $INPUT = [Ss]* ]] || [[ $INPUT = [Qq]* ]] ; } && printf '\n\e[0;32m%s\e[0;31mEXITING...\e[0m\n' "${FLNM^^} INFO keypress $INPUT was detected;  " && exit ; } || { [[ $INPUT = [Bb]* ]] && printf '\n\e[0;32m%s\e[0;33mBREAKING...\e[0m\n' "${FLNM^^} INFO keypress $INPUT was detected;  " && break ; } || { [[ $INPUT = [Hh]* ]] && _SHWHLP_ ; } ; }
for TRCK in "${SNGS[@]}"
do
_DPLY_
{ read -n 1 -rs -t 0.01 INPUT && { { [[ $INPUT = [Aa]* ]] || [[ $INPUT = [Ee]* ]] || [[ $INPUT = [Ss]* ]] || [[ $INPUT = [Qq]* ]] ; } && printf '\n\e[0;32m%s\e[0;31mEXITING...\e[0m\n' "${FLNM^^} INFO keypress $INPUT was detected;  " && exit ; } || { [[ $INPUT = [Bb]* ]] && printf '\n\e[0;32m%s\e[0;33mBREAKING...\e[0m\n' "${FLNM^^} INFO keypress $INPUT was detected;  " && break ; } || { [[ $INPUT = [Hh]* ]] && _SHWHLP_ ; } ; }
_DSLP_
done
done
}

{ [[ -z "${SNGS[@]}" ]] && TMPCMD="$(sed -n '23p' $0 | sed 's/##\ //g')" && printf '\e[0;33m%s\e[0;32m%s\e[0;31mEXITING...\e[0m\n' "${FLNM^^} NOTICE no file name was given;  " "$TMPCMD;  The command '$FLNM help' has more information;  " && exit ; } || _PLYD_
# wae.bash EF
