#!/usr/bin/env bash

chassis=$(< /sys/class/dmi/id/chassis_type)

ask() {
    while true; do
        read -p "$(tput bold)$1 [Y/n]$(tput sgr0) " -r yn
        case "${yn}" in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            "" ) return 0;;
        esac
    done
}

ask "Install yay?" && {
    mkdir -p /home/$USER/perso &&
    cd /home/$USER/perso &&
    pacman -S --needed git base-devel &&
    git clone https://aur.archlinux.org/yay.git &&
    cd yay &&
    makepkg -si
}

ask "Install packages?" && xargs -a /home/$USER/packages-list -I {} yay -S --needed --noconfirm --sudoloop {}

ask "Source .profile in /etc/profile?" && {
    sudo tee -a /etc/profile > /dev/null <<- EOF

    source /home/$USER/.profile 
    EOF
}

ask "Set custom keyboard layout?" && {
    sudo cp /home/$USER/.config/xkb/pwerty /usr/share/X11/xkb/symbols/pwerty &&
    localectl set-x11-keymap pwerty "" "" compose:ralt,altwin:swap_lalt_lwin
}

ask "Faster key repeat rate?" && {
    sudo tee /etc/X11/xorg.conf.d/50-key-repeat.conf > /dev/null <<- EOF
    Section "InputClass"
            Identifier "system-keyboard"
            MatchIsKeyboard "on"
            Option "AutoRepeat" "200 30"
    EndSection
    EOF
}

ask "Disable mouse acceleration?" && {
    sudo tee /etc/X11/xorg.conf.d/50-mouse-accelaration.conf > /dev/null <<- EOF
    Section "InputClass"
            Identifier "My Mouse"
            MatchIsPointer "yes"
            Option "AccelerationProfile" "-1"
            Option "AccelerationScheme" "none"
            Option "AccelSpeed" "-1"
    EndSection
    EOF
}

ask "Disable pc speaker?" && {
    sudo tee /etc/modprobe.d/nobeep.conf > /dev/null <<- EOF
    blacklist pcspkr
    blacklist snd_pcspsudo
    EOF
}

ask "Set rust toolchain?" && rustup default stable

ask "Install haskell stuff?" && {
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh &&
    sudo ln -s /home/$USER/.ghcup/bin/* /usr/local/bin/
}

ask "Install zap plugin manager?" && zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep --branch release-v1

ask "Install chezmoi" && {
    chezmoi init https://github.com/aayko/.dotfiles &&
    chezmoi update
}

ask "Change default shell to zsh?" && chsh -s /usr/bin/zsh $USER

# Test if on a desktop
if [[ chassis -eq 3 ]]; then
    ask "Load desktop monitor config?" && {
        sudo tee /etc/profile > /dev/null <<- EOF
        autorandr --load desktop
        EOF
    }
else
    ask "Map caps lock to escape and ctrl on hold?" && {
        yay -S interception-caps2esc &&
        sudo tee /etc/udevmon.yaml > /dev/null <<- EOF
        - JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
        EOF
        sudo tee /etc/systemd/system/udevmon.service > /dev/null <<- EOF
        [Unit]
        Description=udevmon
        Wants=systemd-udev-settle.service
        After=systemd-udev-settle.service

        [Service]
        ExecStart=/usr/bin/nice -n -20 /usr/local/bin/udevmon -c /etc/udevmon.yaml

        [Install]
        WantedBy=multi-user.target
        EOF
        systemctl enable udevmon.service --now
    }
fi
