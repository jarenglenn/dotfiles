#!/usr/bin/env bash

if [ -z "$@" ]; then
  greenclip print
else
  greenclip print "$1"
  coproc (xdotool key --clearmodifiers "ctrl+v" &)
  exit 0
fi
