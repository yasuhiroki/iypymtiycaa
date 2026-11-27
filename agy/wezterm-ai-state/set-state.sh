#!/bin/sh
set -eu

state="${1:-}"
if [ $# -ge 2 ] && [ -n "$2" ]; then
  response="$2"
else
  response="{}"
fi

case "$state" in
  running)  encoded="cnVubmluZw==" ;;
  ask)      encoded="YXNr" ;;
  complete) encoded="Y29tcGxldGU=" ;;
  idle)     encoded="aWRsZQ==" ;;
  *)
    printf 'Invalid AI_STATE: %s\n' "$state" >&2
    exit 1
    ;;
esac

if [ -n "${WEZTERM_PANE:-}" ] && [ -w /dev/tty ]; then
  # Do not fail the hook if /dev/tty rejects the write; stdout must still emit valid JSON.
  printf '\033]1337;SetUserVar=AI_STATE=%s\007' "$encoded" > /dev/tty 2>/dev/null \
    || printf 'wezterm-ai-state: failed to write /dev/tty\n' >&2
fi

printf '%s\n' "$response"
