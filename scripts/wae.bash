#!/usr/bin/env bash
################################################################################
## Copyright 2022 by TermuxArch, all rights reserved, please see LICENSE 🌎 🌍 🌏

## snooze time = time between each play in seconds

## INVOCATIONS:
## wae c[at]			print this file on standard output
## wae h[elp]			show the help screen
## wae *.mp3 path/*.mp3 8 32	play sound files and wait from eight to thirty two seconds between each play
## wae file.mp3			play one sound file continually using default snooze time to pause between each play
## wae w				print this file on standard output including newline, word, and byte counts

## OPTIONS WHILE PLAYING:
## a[bort]		abort at end of current task
## b[reak]		break at end of current task
## c[at]		cat this file at end of current task
## CTRL+\		quit current task
## CTRL+C		quit wae session
## e[xit]		exit at end of current task
## h[elp]		print help at end of current task
## l[ist]		list playlist at end of current task
## q[uit]		quit at end of current task
## s[huffle]	shuffle playlist at end of current task
## w[c]		print newline, word, and byte counts for this file on standard output

## SYNTAX:
## wae audio_file[s] [audio files] [min snooze time] [max snooze time]

## Variables STMN=32 and STMX=496 can be edited in order to set the default minimum and maximum snooze times.  Please see 'wae cat' for more information.

## Multiple sessions can be used in order to run commands 'wae arguments' simultaneously and to switch seamlessly between plays.

## The command 'wait an event' is derived from the theories of grey music cognition and music as medicine.  Termux group discussions circa 2018 at Termux community channels were very helpful before the SDRausty account was banned by Termux curators doing the work of open source code squatters.  Please reference https://github.com/SDRausty/builtAPKs/issues/2 for more information about the topic of open source code squatting.
################################################################################
set -eu
FLNM="${0##*/}"
STMN=32
STMX=496
[ "${1:-}" != "" ] && { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] ; } && printf '\e[0;32m%s\e[0;31m  EXITING...\e[0m\n' "${FLNM^^} INFO cat $0;" && cat "$0" && exit
[ "${1:-}" != "" ] && [[ "${1//-}" = [Ww] ]] && printf '\e[0;32m%s\e[0;31m  EXITING...\e[0m\n' "${FLNM^^} INFO cat $0 && wc $0;" && cat "$0" &&  wc "$0" && exit
_SHWHLP_() {
TMPCMD="$(sed -n '3,32p' "$0" | sed 's/##\ //g')" && printf '\e[0;32m%s\e[0m\n' "${FLNM^^} HELP $TMPCMD"
}
[ "${1:-}" != "" ] && { [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] ; } && _SHWHLP_ && exit

for TMPVRBL in "$@"
do
[[ "$TMPVRBL" =~ ^[0-9]+$ ]] || SNGS+=("$TMPVRBL" )
[[ "$TMPVRBL" =~ ^[0-9]+$ ]] && { { [[ -z "${FRSTNM:-}" ]] && FRSTNM="$TMPVRBL" ; } || { [[ -z "${SCNDNM:-}" ]] && SCNDNM="$TMPVRBL" ; } ; }
done
FRSTNM="${FRSTNM:-$STMN}"
SCNDNM="${SCNDNM:-$STMX}"
[[ "$FRSTNM" -le "$SCNDNM" ]] || { RSRVNM="$FRSTNM" && FRSTNM="$SCNDNM" && SCNDNM="$RSRVNM" ; }

_DPLY_(){
printf '\e[2K\rPlaying %s...  ' "'${TRCK##*/}'"
play-audio "$TRCK" || printf '\e[2K\r\e[0;33m%s\e[0;32mCONTINUING...\e[0m' "${FLNM^^} NOTICE play-audio $TRCK;  "
}

_DSLP_(){
{ SHFNNT="$(shuf -n 1 -i "$FRSTNM"-"$SCNDNM")" && printf '\e[2K\r\e[0;32m%s\e[0m' "${FLNM^^} INFO snoozing for ${SHFNNT:-24} seconds after playing '${TRCK##*/}'...  " && sleep "${SHFNNT:-24}" ; } || { printf '\e[2K\r\e[0;33m%s\e[0;32mCONTINUING...  \e[0m' "${FLNM^^} NOTICE not snoozing for ${SHFNNT:-24} seconds after playing '${TRCK##*/}';  Snoozing for six seconds...  " && sleep 6 ; }
}

_PLYD_(){
while :
do
_PLYN_
done
}

_PLYN_(){
for TRCK in "${SNGS[@]}"
do
{ _RDLN_ && { [[ $REPLY = [Bb]* ]] || [[ $REPLY = [Ss]* ]] ; } && break ; }
_DPLY_
{ _RDLN_ && { [[ $REPLY = [Bb]* ]] || [[ $REPLY = [Ss]* ]] ; } && break ; }
_DSLP_
done
}

_RDLN_(){
read -n 999 -rs -t 0.01
{ [[ $REPLY = [Aa]* ]] || [[ $REPLY = [Ee]* ]] || [[ $REPLY = [Qq]* ]] ; } && printf '\e[0;32m  %s\e[0;31mEXITING...\e[0m\n' "${FLNM^^} INFO keypress '$REPLY' was detected;  " && exit
[[ $REPLY = [Bb]* ]] && printf '\e[0;32m  %s\e[0;33mBREAKING...\e[0m\n' "${FLNM^^} INFO keypress '$REPLY' was detected;  "
[[ $REPLY = [Cc]* ]] && printf '\e[0;32m  %s\e[0;32m  CONTINUING...\e[0m\n' "${FLNM^^} INFO cat $0;" && cat "$0"
[[ $REPLY = [Hh]* ]] && printf '  ' && _SHWHLP_
[[ $REPLY = [Ll]* ]] && printf '\e[1;32m  %s\n' "${FLNM^^} NOTICE listing playlist:" && printf '\e[0;32m%s\n' "${SNGS[@]}" && printf '\e[1;32mCONTINUING...\e[0m\n'
[[ $REPLY = [Ss]* ]] && OIFS="$IFS" && IFS=$'\n' && SNGS=( $(shuf -e "${SNGS[@]}") ) && IFS="$OIFS" && printf '\e[1;32m  %s\n' "${FLNM^^} NOTICE shuffling playlist:" && printf '\e[0;32m%s\n' "${SNGS[@]}" && printf '\e[1;32mCONTINUING...\e[0m\n'
[[ $REPLY = [Ww]* ]] && printf '\e[0;32m  %s\e[0;32m  CONTINUING...\e[0m\n' "${FLNM^^} INFO wc $0;" && wc "$0"
}

_STRTSRVC_(){
TMPCMD="start service wake lock" && am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null && printf '\e[0;32m%sCONTINUING...\e[0m\n' "${FLNM^^} INFO $TMPCMD;  " || printf '\e[0;33m%s\e[0;32mCONTINUING...\e[0m\n' "${FLNM^^} NOTICE $TMPCMD;  "
}

{ [[ -z "${SNGS:-}" ]] && TMPCMD="$(sed -n '28p' "$0" | sed 's/##\ //g')" && printf '\e[0;33m%s\e[0;32m%s\e[0;31mEXITING...\e[0m\n' "${FLNM^^} NOTICE no file name was given;  " "$TMPCMD;  The command '$FLNM help' has more information;  " && exit ; } || { _STRTSRVC_ && _PLYD_ ; }
# wae.bash EF
