#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Create logs
printf "\n======================\n\n" | tee -a /tmp/polybar.log

# Launch polybar
polybar barleft --config=~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
polybar barright --config=~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown
