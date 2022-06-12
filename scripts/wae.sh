#!/usr/bin/env sh
am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService || printf '%s\n' "${0##*/} SIGNAL am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService;  Continuing..."
ARG2="${2:-16}"
ARG3="${3:-256}"
_PLAYAUDIO_(){
while true
do
printf '%s\n' "Playing ${1##*/}..."
play-audio "${1:-no file name was provided}"
SHFNNT="$(shuf -n 1 -i $ARG2-$ARG3)"
printf '%s\n' "Snoozing for ${SHFNNT:-24} seconds..."
sleep "${SHFNNT:-24}"
done
}
_PLAYAUDIO_ "$@"
# wae.sh EF
