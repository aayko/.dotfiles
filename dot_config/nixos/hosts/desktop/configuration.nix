{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixpc";

  boot.supportedFilesystems = [ "ntfs" ];

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off
  '';

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xset}/bin/xset s off -dpms
  '';

  services.xserver.videoDrivers = [ "nvidia" ];
}
