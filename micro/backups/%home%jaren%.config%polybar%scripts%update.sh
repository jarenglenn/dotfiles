#!/bin/sh

count=$(paru -Qu | wc -l)

if [ "$count" -gt -0 ]; then
	alacritty -e paru -Syu
else
	notify-send --icon="f" "No outdated packages."
fi

