{ config, pkgs, ... }:

let
  change-brightness = import scripts/change-brightness.nix { inherit pkgs; };
  change-volume = import scripts/change-volume.nix { inherit pkgs; };
  color-picker = import scripts/color-picker.nix { inherit pkgs; };
  battery-notify = import scripts/battery-notify.nix { inherit pkgs; };

  myDmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = "https://github.com/aayko/dmenu/archive/main.tar.gz";
      sha256 = "1rg4m4pg3irkbnn40vmab2wqcalr96499lfkjb36w2p38crkarci";
    };
  });
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import
          (fetchTarball
            "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
          { };
        polybar = pkgs.polybar.override {
          i3Support = true;
        };
        j4-dmenu-desktop = pkgs.j4-dmenu-desktop.override {
          dmenu = myDmenu;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # gui
    gthumb
    unstable.xdg-terminal-exec
    celluloid
    gnome.gnome-disk-utility
    gnome.gnome-calculator
    obs-studio
    scrcpy
    vesktop
    ungoogled-chromium
    gnome.seahorse
    qbittorrent
    unstable.melonDS
    mpv
    imv
    zathura
    _1password-gui
    dunst
    gnome.gnome-weather
    gnome.nautilus
    gparted
    localsend
    pavucontrol
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        jdinhlife.gruvbox
        vscodevim.vim
        github.copilot
        github.copilot-chat
      ];
    })

    # sddm
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        cursorColor = "#ffffff";
        passwordCharacter = "*";
      };
    })
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtquickcontrols2
    qt6.qtdeclarative

    # haskellPackages.ghcup

    # tui
    neovim
    ncspot
    bluetuith

    # keyring ?
    pinentry-gnome
    libgcrypt
    libassuan
    polkit_gnome
    libgnome-keyring
    polkit
    gpgme

    # cli
    nix-index
    gtk-engine-murrine
    ueberzugpp
    xdg-user-dirs
    speechd
    mimeo
    colloid-icon-theme
    gnome-themes-extra
    tree
    zip
    autorandr
    spotifyd
    unzip
    age
    ansible
    jq
    gzip
    bc
    btop
    cron
    dict
    gnumake
    plocate
    ripgrep
    sassc
    socat
    sshfs-fuse
    gnutar
    libnotify
    chezmoi
    git
    rustup
    nodejs
    gcc
    fzf
    ly
    wget
    pamixer
    tldr
    neofetch
    nitch
    playerctl
    home-manager
    killall
    xdg-ninja
    ntfs3g
    gcc

    # lf
    mdcat
    transmission
    colordiff
    fontforge
    ffmpeg
    ffmpegthumbnailer
    ctpv
    bat
    atool
    trash-cli
    lf

    # scripts
    change-brightness
    change-volume
    color-picker
    battery-notify

    # xorg
    autotiling
    polybar
    betterlockscreen
    feh
    maim
    xclip
    xcolor
    xclip
    xdotool
    xss-lock
    xsel
    j4-dmenu-desktop
    myDmenu
    (st.overrideAttrs (oldAttrs: {
      src = fetchurl {
        url = "https://github.com/aayko/st/archive/main.tar.gz";
        sha256 = "00wqqvxvjy8c8hiyf0qpznmdczglb7ac8ql28q7vik837s3gpiby";
      };
    }))
  ];
}
