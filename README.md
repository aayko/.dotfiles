# Warning
Make sure to remove the pwerty layout from input:kb_layout in hyprland config otherwise hyprland will crash

# Install packages
```
cat packages-list | xargs -I {} yay -S --needed --noconfirm --sudoloop {}
```

# Remap Caps Lock to ESC and CTRL

1. Install caps2esc
```
sudo pacman -S interception-caps2esc  
```

2. Create udevmon job
```
sudo cp extras/config.yaml /etc/interception/udevmon.d/
```
3. Create udevmon service
```
sudo cp extras/udevmon.service /etc/systemd/system/
```

4. Start service and start at startup
```
systemctl enable --now udevmon
```

# Remove default folders
Set enabled to False in /etc/xdg/user-dirs.conf 

# Colloid theme install command
```
./install.sh -d ~/.local/share/themes -t grey -c dark -l --tweaks rimless black
```

# Beep ?
https://wiki.archlinux.org/title/PC_speaker#Globally

Dotfiles managed using chezmoi
