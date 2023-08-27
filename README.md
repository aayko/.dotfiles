# Remap caps lock to esc on tap and ctrl on hold

Install caps2esc
```
sudo pacman -S interception-caps2esc`  
```

Create udevmon job
```
`sudo echo "- JOB: intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE
DEVICE:
EVENTS:
EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
" > /etc/interception/udevmon.d/config.yaml
```
Create udevmon service
```
sudo echo "[Unit]
Description=udevmon
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service

[Service]
ExecStart=/usr/bin/nice -n -20 /usr/bin/udevmon

[Install]
WantedBy=multi-user.target" > /ect/systemd/system/udevmon.service`
```

Start service and start at startup
```
systemctl enable --now udevmon
```
