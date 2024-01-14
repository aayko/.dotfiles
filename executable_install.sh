chassis=$(< /sys/class/dmi/id/chassis_type)

echo -e "\nsource /home/ayko/.profile" >> /etc/profile
echo 'Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "AutoRepeat" "200 30"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-key-repeat.conf > /dev/null

echo 'Section "InputClass"
    	Identifier "My Mouse"
    	MatchIsPointer "yes"
    	Option "AccelerationProfile" "-1"
    	Option "AccelerationScheme" "none"
    	Option "AccelSpeed" "-1"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-mouse-accelaration.conf > /dev/null

cp /home/$USER/.config/xkb/pwerty /usr/share/X11/xkb/symbols/pwerty
localectl --no-convert set-x11-keymap pwerty,us grp:win_space_toggle,compose:ralt,altwin:swap_alt_win

# test if on a desktop
if [[ chassis -eq 3 ]]; then
    echo -e "\nxrandr --output HDMI-1 --off" >> /usr/share/sddm/scripts/Xsetup
    echo -e "\nautorandr --load desktop" >> /etc/profile
    echo 'Section "Monitor"
        Option "DPMS" "true"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-dpms.conf > /dev/null
fi
