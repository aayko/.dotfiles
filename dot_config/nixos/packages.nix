{ config, pkgs, laptop, desktop, ... }:

let
  change-brightness = import scripts/change-brightness.nix { inherit pkgs; };
  change-volume = import scripts/change-volume.nix { inherit pkgs; };
  color-picker = import scripts/color-picker.nix { inherit pkgs; };
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
    neovim
    fzf
    ly
    wget
    chezmoi
    git
    rustup
    nodejs
    gcc
    lf
    dunst
    libnotify
    unzip
    age
    ansible
    jq
    gzip
    bc
    btop
    colordiff
    cron
    dict
    gnumake
    plocate
    ripgrep
    sassc
    socat
    sshfs-fuse
    gnutar
    transmission
    udiskie
    tree
    zip
    autorandr
    spotifyd
    ncspot
    ueberzugpp
    zathura
    xdg-user-dirs
    vesktop
    ungoogled-chromium
    speechd
    gnome.seahorse
    scrcpy
    qbittorrent
    polkit
    polkit_gnome
    obs-studio
    mimeo
    mpv
    unstable.melonDS
    mdcat
    imv
    gtk-engine-murrine
    gthumb
    colloid-icon-theme
    gnome-themes-extra
    libgnome-keyring
    gnome.gnome-disk-utility
    gnome.gnome-calculator
    fontforge
    ffmpeg
    ffmpegthumbnailer
    ctpv
    celluloid
    bat
    atool
    _1password-gui
    unstable.xdg-terminal-exec
    trash-cli
    nim
    nimPackages.nimble
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        cursorColor = "#ffffff";
        passwordCharacter = "*";
      };
    })
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        jdinhlife.gruvbox
        vscodevim.vim
        github.copilot
        github.copilot-chat
      ];
    })
    pamixer
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtquickcontrols2
    qt6.qtdeclarative
    pinentry-gnome
    gpgme
    libgcrypt
    libassuan
    tldr
    # haskellPackages.ghcup
    xdg-ninja
    gnome.gnome-weather
    gnome.nautilus
    nitch
    playerctl
    home-manager
    killall
    bluetuith
    ntfs3g
    gparted
    localsend
    pavucontrol

    # scripts
    change-brightness
    change-volume
    color-picker
  ];
}

