{ pkgs, ... }:

{
  imports = [
    ./via.nix
    ./1password.nix
    ./fonts.nix
    ./packages.nix
    ./security.nix
    ./xserver.nix
  ];

  services.openssh.enable = true;
  services.dbus.enable = true;
  services.printing.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.nm-applet.enable = true;

  services.autorandr = {
    enable = true;
    hooks.postswitch = {
      "set-wallpaper" = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/.config/i3/wallpaper.png";
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
}
