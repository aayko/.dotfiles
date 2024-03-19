{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.graphicalPackages.enable = lib.mkEnableOption "Install graphical packages";
  };

  config = lib.mkIf cfg.graphicalPackages.enable {
    services.openssh.enable = true;
    services.dbus.enable = true;
    services.printing.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.nm-applet.enable = true;

    environment.systemPackages = with pkgs; [
      autorandr
      gtk3
      libnotify
      ly
      blueberry
      celluloid
      dia
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      dunst
      jellyfin-media-player
      gimp
      gnome.gnome-calculator
      gnome.gnome-disk-utility
      gnome.gnome-weather
      gnome.nautilus
      gnome.sushi
      gparted
      gthumb
      imv
      localsend
      melonDS
      mpv
      obs-studio
      pavucontrol
      perl538Packages.FileMimeInfo
      qbittorrent
      scrcpy
      vmware-horizon-client
      (stable.vscode-with-extensions.override {
        vscode = vscodium-fhs;
        vscodeExtensions = with stable.vscode-extensions; [
          bbenoist.nix
          jdinhlife.gruvbox
          vscodevim.vim
        ];
      })
      signal-desktop
      ungoogled-chromium
      zathura

      # gtk
      (colloid-gtk-theme.override {
        themeVariants = [ "grey" ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [ "black" "rimless" ];
      })
      (colloid-icon-theme.override {
        schemeVariants = [ "default" ];
        colorVariants = [ "grey" ];
      })

      # sddm
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          cursorColor = "#ffffff";
          passwordCharacter = "*";
        };
      })
    ];
  };
}

