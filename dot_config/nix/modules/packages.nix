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
    dunst
    librewolf
    gimp
    gnome.gnome-calculator
    gnome.gnome-disk-utility
    gnome.gnome-weather
    gnome.gnome-keyring
    gnome.nautilus
    gnome.seahorse
    gparted
    gthumb
    imv
    localsend
    melonDS
    mpv
    obs-studio
    pavucontrol
    qbittorrent
    scrcpy
    (vesktop.overrideAttrs (oldAttrs: {
      nativeBuildInputs = [
        copyDesktopItems
        nodePackages.pnpm
        nodejs_21
        makeWrapper
      ];
    }))
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
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
    polkit_gnome
    ripgrep
    rustup
    sassc
    socat
    speechd
    spotifyd
    sshfs-fuse
    tldr
    tree
    udiskie
    unzip
    wget
    wine
    xdg-ninja
    xdg-user-dirs
    zip

    lf
    (ctpv.override {
      ueberzug = ueberzugpp;
    })
    ueberzugpp
    poppler_utils
    libreoffice
    trash-cli
    xdragon

    # scripts
    (import ./scripts/change-brightness.nix { inherit pkgs; })
    (import ./scripts/change-volume.nix { inherit pkgs; })
    (import ./scripts/color-picker.nix { inherit pkgs; })
    (import ./scripts/lock.nix { inherit pkgs; })
    (import ./scripts/powermenu.nix { inherit pkgs; })
    (import ./scripts/screenshot.nix { inherit pkgs; })

    # xorg
    autotiling
    betterlockscreen
    (j4-dmenu-desktop.override {
      dmenu = bemenu;
    })
    bemenu
    maim
    picom
    (polybar.override {
      i3Support = true;
    })
    xdo
    (st.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "aayko";
        repo = "st";
        rev = "main";
        hash = "sha256-kjefKnnAX4rpmt81fmqZRjJrsUdz0NU6ngWh4G+iWfA=";
      };
    }))
    xclip
    xclip
    xcolor
    xdotool
    xsel
    xss-lock

    # dev
    ghc
    haskellPackages.haskell-language-server

    php
    nodePackages_latest.intelephense

    python3
    texliveMedium
    tree-sitter

    nodePackages.bash-language-server
    clang-tools
    lua-language-server
    rnix-lsp
    texlab
    zulu
    ant
  ];
}
