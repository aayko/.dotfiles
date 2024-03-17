{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.via.enable = lib.mkEnableOption "Setup via";
  };

  config = lib.mkIf cfg.via.enable {
    hardware.keyboard.qmk.enable = true;
    environment.systemPackages = with pkgs; [ via ];
    services.udev.packages = [ pkgs.via ];
  };
}
