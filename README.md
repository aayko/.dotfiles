# Remap Caps Lock to ESC and CTRL

1. Install caps2esc
```
sudo pacman -S interception-caps2esc  
```

2. Create udevmon job
```
`sudo echo "- JOB: intercept -g $DEVNODE | caps2esc -t 1 | uinput -d $DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
" > /etc/interception/udevmon.d/config.yaml
```
3. Create udevmon service
```
sudo echo "[Unit]
Description=udevmon
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service

[Service]
ExecStart=/usr/bin/nice -n -20 /usr/bin/udevmon

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/udevmon.service
```

4. Start service and start at startup
```
systemctl enable --now udevmon
```
