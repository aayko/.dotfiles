#!/usr/bin/bash

if [[ $XDG_SESSION_TYPE == "x11" ]]; then
    systemctl suspend
else
    swayidle -w \
        timeout 5 "hyprctl dispatch dpms off" \
        resume 'hyprctl dispatch dpms on' &

    swaylock

    kill %%
fi
