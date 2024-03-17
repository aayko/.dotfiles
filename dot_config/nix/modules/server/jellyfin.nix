{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.jellyfin.enable = lib.mkEnableOption "Setup jellyfin server";
  };

  config = lib.mkIf cfg.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      user = "ayko";
    };
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
