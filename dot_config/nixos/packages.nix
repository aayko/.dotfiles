{ config, pkgs, laptop, desktop, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  desktop = hostname == "nixpc";
  laptop = hostname == "nixlaptop";

  change-brightness = import scripts/change-brightness.nix { inherit pkgs; };
  change-volume = import scripts/change-volume.nix { inherit pkgs; };
  color-picker = import scripts/color-picker.nix { inherit pkgs; };
  battery-notify = import scripts/battery-notify.nix { inherit pkgs; };
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
  ];

  services.cron = {
    enable = laptop;
    systemCronJobs =
      if laptop then [
        "*/5 * * * * ${battery-notify}"
      ] else [ ];
  };

}

