#!/bin/bash

image="$HOME/.local/share/icons/paste.png"

if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    xcolor -s clipboard && notify-send --icon "$image" "Copied $(xsel -ob) to clipboard"
else
    hyprpicker -ra && notify-send --icon "$image" "Copied $(wl-paste) to clipboard"
fi
