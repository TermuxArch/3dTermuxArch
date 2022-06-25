#!/usr/bin/env bash
# Copyright 2022 by TermuxArch. All rights reserved, please see LICENSE 🌎 🌍 🌏
##############################################################################
set -eu
ARG0="${0##*/}"
ARG1="${1:-NO FILE NAME WAS GIVEN}"
ARG2="${2:-32}"
ARG3="${3:-512}"
ARG4="${4:-NO FILE NAME WAS GIVEN}"
ARG5="${5:-NO FILE NAME WAS GIVEN}"
ARG6="${6:-NO FILE NAME WAS GIVEN}"
ARG7="${7:-NO FILE NAME WAS GIVEN}"
ARG8="${8:-NO FILE NAME WAS GIVEN}"
ARG9="${9:-NO FILE NAME WAS GIVEN}"
[[ "$ARG2" =~ ^[0-9]+$ ]] || { printf '%s\n' "${ARG0^^} SIGNAL the second argument must be a number;  EXITING..." && exit ; }
[[ "$ARG3" =~ ^[0-9]+$ ]] || { printf '%s\n' "${ARG0^^} SIGNAL the third argument must be a number;  EXITING..." && exit ; }
[[ "$ARG2" -lt "$ARG3" ]] || { printf '%s\n' "${ARG0^^} SIGNAL the third argument must be less than the second argument;  EXITING..." && exit ; }
_DPLY_(){
printf '%s\n' "Playing '${TRCK##*/}'..."
play-audio "$TRCK" || printf '%s\n' "${ARG0^^} SIGNAL play-audio $TRCK;  CONTINUING..."
SHFNNT="$(shuf -n 1 -i "$ARG2"-"$ARG3")"
printf '%s\n' "${ARG0^^} INFO snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
}
_PLYD_(){
{ am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null && printf '%s\n' "${ARG0^^} INFO am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..." ; } || printf '%s\n' "${ARG0^^} SIGNAL am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..."
while true
do
for TRCK in "$ARG1" "$ARG4" "$ARG5" "$ARG6" "$ARG7" "$ARG8" "$ARG9"
do
{ [[ "$TRCK"  == "NO FILE NAME WAS GIVEN" ]] && printf '%s\n' "${ARG0^^} SIGNAL no file name was given;  CONTINUING..." ; } || _DPLY_ "$TRCK"
done
done
}
[ -n "${1:-}" ] && { { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] || [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] || [[ "${1//-}" = [Vv] ]]  || [[ "${1//-}" = [Vv][Ee] ]]  || [[ "${1//-}" = [Vv][Ee][Rr] ]]  || [[ "${1//-}" = [Vv][Ee][Rr][Ss] ]]  || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii] ]]  || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo] ]]  || [[ "${1//-}" = [Vv][Ee][Rr][Ss][Ii][Oo][Nn] ]]  ; } && { printf '\e[0;32m%s\n' "${ARG0^^} INFO cat $0;  CONTINUING..." && cat "$0" ; exit ; } ; }
{ [[ "$ARG1"  == "NO FILE NAME WAS GIVEN" ]] && printf '%s\n' "${ARG0^^} SIGNAL no file name was given;  EXITING..." && exit ; } || _PLYD_
# wae EF
