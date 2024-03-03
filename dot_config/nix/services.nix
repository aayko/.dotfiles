{ config, pkgs, ... }:

let
  laptop = builtins.readFile "/etc/hostname" == "nixlaptop\n";

  commonCommands = ''
    ${pkgs.playerctl}/bin/playerctld daemon &
    ${pkgs.dunst}/bin/dunst &
    ${pkgs.xbanish}/bin/xbanish &
    ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/pictures/wallpapers/ghibli/5m5kLI9.png &
  '';

  charging-notify = import scripts/charging-notify.nix { inherit pkgs; };
in
{
  services.xserver = {
    enable = true;
    videoDrivers = if laptop then [ ] else [ "nvidia" ];
    displayManager.ly = {
      enable = false;
      defaultUser = "ayko";
    };
    displayManager.sddm = {
      enable = true;
      theme = "where_is_my_sddm_theme";
    };
    displayManager.setupCommands =
      if ! laptop then ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off
      '' else '''';
    displayManager.sessionCommands =
      if ! laptop then ''
        ${pkgs.xorg.xset}/bin/xset s off -dpms
        ${pkgs.autorandr}/bin/autorandr --load desktop-default
        ${pkgs.playerctl}/bin/playerctld daemon &
        ${pkgs.dunst}/bin/dunst &
        ${pkgs.xbanish}/bin/xbanish &
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/pictures/wallpapers/ghibli/5m5kLI9.png &
      '' else ''
        ${pkgs.playerctl}/bin/playerctld daemon &
        ${pkgs.dunst}/bin/dunst &
        ${pkgs.xbanish}/bin/xbanish &
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/pictures/wallpapers/ghibli/5m5kLI9.png &
      '';
    xkb.layout = "pwerty";
    xkb.variant = "";
    xkb.model = "";
    xkb.options = "compose:ralt,altwin:swap_lalt_lwin";
    autoRepeatDelay = 200;
    autoRepeatInterval = 33;
    xkb.extraLayouts.pwerty = {
      description = "Modified qwerty for programming";
      languages = [ "eng" ];
      symbolsFile = /home/ayko/.config/xkb/symbols/pwerty;
    };
  };

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      autotiling
    ];
  };

  services.xserver.libinput = {
    mouse.accelProfile = "flat";
    enable = true;
    touchpad = {
      naturalScrolling = laptop;
      tapping = laptop;
      tappingDragLock = false;
      disableWhileTyping = true;
    };
  };

  services.openssh.enable = true;
  services.dbus.enable = true;
  services.sshd.enable = true;
  services.printing.enable = true;
  services.auto-cpufreq.enable = laptop;

  services.udisks2.enable = true;

  services.udev.extraRules =
    if laptop then
      ''
        SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
        ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '${charging-notify}/bin/charging-notify 0'"
        ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '${charging-notify}/bin/charging-notify 1'"
      '' else '''';

  services.logind.lidSwitch = "ignore";
}