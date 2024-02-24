#!/usr/bin/env bash

echo "" > ~/steam-252950.log

eval 'PROTON_LOG=1 "$@"' &

while ! grep "Initializing Engine Completed" ~/steam-252950.log > /dev/null; do
    sleep 1
done

protontricks -c 'wine ~/.local/bin/inject.exe' 252950
