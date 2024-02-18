#!/usr/bin/env bash

lock="lock"
hibernate="hibernate"
shutdown="shutdown"
reboot="reboot"
windows="windows"

options="$shutdown\n$reboot\n$windows"

chosen="$(echo -e "$options" | dmenu)"
case $chosen in
    "$lock")
        lock
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
    "$hibernate")
        systemctl hibernate
        lock
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$windows")
        systemctl reboot --boot-loader-entry=auto-windows
        ;;
esac
