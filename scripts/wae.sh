#!/usr/bin/env bash
set -eu
ARG0="${0##*/}"
ARG1="${1:-NO FILE NAME WAS GIVEN}"
ARG2="${2:-16}"
ARG3="${3:-256}"
{ am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null && printf '%s\n' "${ARG0^^} INFO am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..." ; } || printf '%s\n' "${ARG0^^} SIGNAL am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  CONTINUING..."
_PLAYAUDIO_(){
while true
do
printf '%s\n' "Playing '${ARG1##*/}'..."
play-audio "$ARG1" || printf '%s\n' "${ARG0^^} SIGNAL play-audio $ARG1;  CONTINUING..."
SHFNNT="$(shuf -n 1 -i $ARG2-$ARG3)"
printf '%s\n' "${ARG0^^} INFO snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
done
}
_PLAYAUDIO_ "$@"
# wae.sh EF
