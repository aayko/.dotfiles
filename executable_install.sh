chassis=$(< /sys/class/dmi/id/chassis_type)

# Install yay
mkdir -p /home/ayko/perso
cd /home/ayko/perso
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

cat /home/ayko/packages-list | xargs -I {} yay -S --needed --noconfirm --sudoloop {}

# Source .profile
echo -e "\nsource /home/ayko/.profile" >> /etc/profile

# Faster key repeat rate
echo 'Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "AutoRepeat" "200 30"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-key-repeat.conf > /dev/null

# Disable mouse acceleration
echo 'Section "InputClass"
    	Identifier "My Mouse"
    	MatchIsPointer "yes"
    	Option "AccelerationProfile" "-1"
    	Option "AccelerationScheme" "none"
    	Option "AccelSpeed" "-1"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-mouse-accelaration.conf > /dev/null

# Set custom keyboard layout
cp /home/ayko/.config/xkb/pwerty /usr/share/X11/xkb/symbols/pwerty
localectl --no-convert set-x11-keymap pwerty,us grp:win_space_toggle,compose:ralt,altwin:swap_alt_win

# Disable default user directories
sudo sed -i 's/enabled=True/enabled=False/g' /etc/xdg/user-dirs.conf

# Disable pc speaker
echo 'blacklist pcspkr
blacklist snd_pcsp' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null

# Test if on a desktop
if [[ chassis -eq 3 ]]; then
    # Turn off second monitor
    echo -e "\nxrandr --output HDMI-1 --off" >> /usr/share/sddm/scripts/Xsetup

    # Load desktop monitor config
    echo -e "\nautorandr --load desktop" >> /etc/profile

    # Disable screen turning off
    echo 'Section "Monitor"
        Option "DPMS" "true"
EndSection' | sudo tee /etc/X11/xorg.conf.d/50-dpms.conf > /dev/null
else
    # Maps caps lock to escape and ctrl on hold
    yay -S interception-caps2esc  
    echo ' - JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
   DEVICE:
     EVENTS:
       EV_KEY: [KEY_CAPSLOCK, KEY_ESC]' | sudo tee /etc/interception/udevmon.d/config.yaml > /dev/null
    echo ' [Unit]
 Description=udevmon
 Wants=systemd-udev-settle.service
 After=systemd-udev-settle.service

 [Service]
 ExecStart=/usr/bin/nice -n -20 /usr/local/bin/udevmon -c /etc/udevmon.yaml

 [Install]
 WantedBy=multi-user.target' | sudo tee /etc/systemd/system/udevmon.service > /dev/null
    systemctl enable udevmon.service --now
fi
