{ pkgs, ... }:

{
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
      vscodeExtensions = with stable.vscode-extensions; [
        bbenoist.nix
        jdinhlife.gruvbox
        vscodevim.vim
        github.copilot
        github.copilot-chat
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
}

