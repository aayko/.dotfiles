{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  imports = [
    ./via.nix
    ./1password.nix
    ./fonts.nix
    ./packages.nix
    ./security.nix
    ./xserver.nix
  ];

  options = {
    mynix.graphical.enable = lib.mkEnableOption "Setup graphical config";
  };

  config = lib.mkIf cfg.graphical.enable {
    mynix.fontConfig.enable = true;
    mynix.xserver.enable = true;
    mynix.graphicalPackages.enable = true;
    mynix.via.enable = true;

    mynix._1password.enable = true;
    mynix.security.enable = true;

    services.autorandr = {
      enable = true;
      hooks.postswitch = {
        "set-wallpaper" = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/.config/i3/wallpaper.png";
      };
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;
  };
}
