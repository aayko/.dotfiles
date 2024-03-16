{ pkgs, ... }:

{
  imports = [
    ./network
    ./security.nix
    ./boot.nix
  ];

  services.autorandr = {
    enable = true;
    hooks.postswitch = {
      "set-wallpaper" = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/.config/i3/wallpaper.png";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
    useXkbConfig = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;
}
