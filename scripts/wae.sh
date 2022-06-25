#!/usr/bin/env bash
# Copyright 2022 by TermuxArch. All rights reserved, please see LICENSE 🌎 🌍 🌏
##############################################################################
set -eux
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
for TRCK in "$ARG1" "$ARG2" "$ARG3" "$ARG4" "$ARG5" "$ARG6" "$ARG7" "$ARG8" "$ARG9"
do
_DPLY_ "$TRCK"
done
done
}
[ -n "${1:-}" ] && { { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] || [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] ; } && { printf '\e[0;32m%s\n' "${ARG0^^} INFO cat $0;  CONTINUING..." && cat "$0" ; exit ; } ; }
_PLYD_ "$@"
# wae EF
