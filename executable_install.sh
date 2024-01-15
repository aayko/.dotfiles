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
echo -e "setxkbmap -layout pwerty,us -option compose:ralt,altwin:swap_alt_win,grp:win_space_toggle" >> /etc/profile

# Disable pc speaker
echo 'blacklist pcspkr
blacklist snd_pcsp' | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
ln -s /home/ayko/.ghcup/bin/* /usr/local/bin/

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1

chezmoi init https://github.com/aayko/.dotfiles
chezmoi update

chsh -s /usr/bin/zsh ayko

# Test if on a desktop
if [[ chassis -eq 3 ]]; then
    # Load desktop monitor config
    echo -e "\nautorandr --load desktop" >> /etc/profile
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
