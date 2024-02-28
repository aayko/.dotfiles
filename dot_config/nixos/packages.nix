{ config, pkgs, ... }:

let
  change-brightness = import scripts/change-brightness.nix { inherit pkgs; };
  change-volume = import scripts/change-volume.nix { inherit pkgs; };
  color-picker = import scripts/color-picker.nix { inherit pkgs; };

  dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "aayko";
      repo = "dmenu";
      rev = "main";
      hash = "sha256-WOZvw3Pb5JX0osIgqcyw6SANfxBYAQAhy6L/XHiQXoU=";
    };
  });

  ctpv = import ./packages/ctpv.nix { inherit (pkgs) lib stdenv fetchFromGitHub makeWrapper file openssl atool bat chafa delta ffmpeg ffmpegthumbnailer fontforge glow imagemagick jq ueberzugpp; };
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
          dmenu = dmenu;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # gui
    blueberry
    gimp
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
    acpi
    udiskie
    polkit_gnome
    nix-index
    gtk-engine-murrine
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
    killall
    xdg-ninja
    ntfs3g
    gcc

    lf
    ctpv
    trash-cli

    # scripts
    change-brightness
    change-volume
    color-picker

    # xorg
    autotiling
    polybar
    picom
    betterlockscreen
    maim
    xclip
    xcolor
    xclip
    xdotool
    xss-lock
    xsel
    j4-dmenu-desktop
    dmenu
    (st.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "aayko";
        repo = "st";
        rev = "main";
        hash = "sha256-ce3oi76JlFxsMccZqjVQ98vCMPsTBcH6v1F0UZGfJgM=";
      };
    }))
  ];
}
