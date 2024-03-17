{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    user = "ayko";
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
  ];
}
