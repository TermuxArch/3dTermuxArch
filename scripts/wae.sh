#!/usr/bin/env bash
# Copyright 2022 by TermuxArch. All rights reserved, please see LICENSE 🌎 🌍 🌏
##############################################################################
set -eux
ARG0="${0##*/}"
ARG1="${1:-NO FILE NAME WAS GIVEN}"
ARG2="${2:-32}"
ARG3="${3:-512}"
for ARGN in {5..9}
do
{ [ -z "$ARGN" ] && ARG$ARGN="${ARGN:-NO FILE NAME WAS GIVEN}" && echo "ARG$ARGN=${ARGN:-NO FILE NAME WAS GIVEN} echo echo echo echo "  ; }
{ [ -z "$ARGN" ] && echo "ARG$ARGN=${ARGN:-NO FILE NAME WAS GIVEN} echo echo echo echo "  ; }
done
_DPLY_(){
printf '%s\n' "Playing '${ARG1##*/}'..."
play-audio "$ARG1" || printf '%s\n' "${ARG0^^} SIGNAL play-audio $ARG1;  CONTINUING..."
SHFNNT="$(shuf -n 1 -i "$ARG2"-"$ARG3")"
printf '%s\n' "${ARG0^^} INFO snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
}
_PLYD_(){
{ am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null && printf '%s\n' "${ARG0^^} INFO am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..." ; } || printf '%s\n' "${ARG0^^} SIGNAL am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..."
while true
do
_DPLY_
done
}
[ -n "${1:-}" ] && { { [[ "${1//-}" = [Cc] ]] || [[ "${1//-}" = [Cc][Aa] ]] || [[ "${1//-}" = [Cc][Aa][Tt] ]] || [[ "${1//-}" = [Hh] ]] || [[ "${1//-}" = [Hh][Ee] ]] || [[ "${1//-}" = [Hh][Ee][Ll] ]] || [[ "${1//-}" = [Hh][Ee][Ll][Pp] ]] ; } && { printf '\e[0;32m%s\n' "${ARG0^^} INFO cat $0;  CONTINUING..." && cat "$0" ; exit ; } ; }
_PLYD_ "$@"
# wae EF
