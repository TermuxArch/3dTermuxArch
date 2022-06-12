#!/usr/bin/env sh
set -u
ARG0="${0##*/}"
ARG1="${1:-no file name was provided}"
ARG2="${2:-16}"
ARG3="${3:-256}"
am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService || printf '%s\n' "${ARG0^^} SIGNAL am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  Continuing..."
_PLAYAUDIO_(){
while true
do
printf '%s\n' "Playing $ARG1..."
play-audio "$ARG1"
SHFNNT="$(shuf -n 1 -i $ARG2-$ARG3)"
printf '%s\n' "Snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
done
}
_PLAYAUDIO_ "$@"
# wae.sh EF
