#!/bin/bash

icons_path="$HOME/.local/share/icons/"
# Get mute state
muted=$(pactl get-source-mute alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20200111-00.pro-input-0)

if echo "$muted" | grep -q "yes"; then
    pactl set-source-mute alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20200111-00.pro-input-0 0
    send-notify "Microphone Unmuted" --icon "$icons_path/unmuted.png"
else
    pactl set-source-mute alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20200111-00.pro-input-0 1
    send-notify "Microphone Muted" --icon "$icons_path/muted.png"
fi
