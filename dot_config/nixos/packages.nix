{ config, pkgs, ... }:

let
  change-brightness = import scripts/change-brightness.nix { inherit pkgs; };
  change-volume = import scripts/change-volume.nix { inherit pkgs; };
  color-picker = import scripts/color-picker.nix { inherit pkgs; };
  lock = import scripts/lock.nix { inherit pkgs; };
  powermenu = import scripts/powermenu.nix { inherit pkgs; };
  screenshot = import scripts/screenshot.nix { inherit pkgs; };

  dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "aayko";
      repo = "dmenu";
      rev = "main";
      hash = "sha256-WOZvw3Pb5JX0osIgqcyw6SANfxBYAQAhy6L/XHiQXoU=";
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
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # gui
    _1password-gui
    blueberry
    celluloid
    dunst
    gimp
    gnome.gnome-calculator
    gnome.gnome-disk-utility
    gnome.gnome-weather
    gnome.nautilus
    gnome.seahorse
    gparted
    gthumb
    imv
    localsend
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
    unstable.melonDS
    zathura

    # gtk
    (colloid-gtk-theme.override {
      themeVariants = [ "grey" ];
      colorVariants = [ "dark" ];
      sizeVariants = [ "standard" ];
      tweaks = [ "black" ];
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
      ueberzug = unstable.ueberzugpp;
    })
    trash-cli
    xdragon

    # scripts
    change-brightness
    change-volume
    color-picker
    powermenu
    screenshot

    # xorg
    autotiling
    betterlockscreen
    dmenu
    (j4-dmenu-desktop.override {
      dmenu = dmenu;
    })
    maim
    picom
    (polybar.override {
      i3Support = true;
    })
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

    clang-tools
    lua-language-server
    rnix-lsp
    texlab
    zulu
  ];
}
