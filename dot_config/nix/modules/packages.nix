{ pkgs, ... }:

{
  programs.dconf.enable = true;

  programs.zsh = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [
    nh

    # gui
    blueberry
    celluloid
    dia
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    dunst
    librewolf
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

    # tui
    bluetuith
    ncdu
    ncspot
    neovim
    tmux

    # cli
    acpi
    age
    ansible
    autorandr
    bc
    btop
    chezmoi
    cron
    dict
    efibootmgr
    fzf
    gcc
    gcc
    git
    gnumake
    gnutar
    gtk3
    gzip
    jq
    libnotify
    ly
    mimeo
    neofetch
    nitch
    nix-index
    nodejs
    ntfs3g
    pamixer
    playerctl
    plocate
    ripgrep
    rustup
    sassc
    socat
    speechd
    stable.spotifyd
    sshfs-fuse
    tldr
    trash-cli
    tree
    udiskie
    unzip
    wget
    wine
    xdg-ninja
    xdg-user-dirs
    zip

    # lf
    lf
    (ctpv.override {
      ueberzug = ueberzugpp;
    })
    ueberzugpp
    poppler_utils
    libreoffice
    xdragon

    # scripts
    (import ./scripts/change-brightness.nix { inherit pkgs; })
    (import ./scripts/change-volume.nix { inherit pkgs; })
    (import ./scripts/color-picker.nix { inherit pkgs; })
    (import ./scripts/lock.nix { inherit pkgs; })
    (import ./scripts/powermenu.nix { inherit pkgs; })
    (import ./scripts/screenshot.nix { inherit pkgs; })

    # dev

    # haskell
    ghc
    haskellPackages.haskell-language-server

    # php
    php
    nodePackages_latest.intelephense

    # latex
    texlab
    texliveMedium

    # nix
    nil
    nixpkgs-fmt

    # java
    zulu
    ant

    # shell
    shellcheck
    nodePackages.bash-language-server

    # lua
    lua-language-server
    stylua

    python3
    tree-sitter
    clang-tools
  ];
}
