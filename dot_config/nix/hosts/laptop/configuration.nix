{ pkgs, ... }:

let
  charging-notify = import ../../modules/scripts/charging-notify.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/extra/capsLockRemap.nix
    ../../modules/extra/suspendAndHibernate.nix
  ];

  networking.hostName = "nixlaptop";
  hardware.brillo.enable = true;

  boot.blacklistedKernelModules = [ "pcspkr" ];

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '${charging-notify}/bin/charging-notify 0'"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '${charging-notify}/bin/charging-notify 1'"
  '';

  services.logind.lidSwitch = "ignore";
  services.auto-cpufreq.enable = true;

  services.xserver.libinput = {
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      tappingDragLock = false;
      disableWhileTyping = true;
    };
  };
}
