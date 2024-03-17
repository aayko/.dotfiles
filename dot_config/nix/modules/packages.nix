{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    nh

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
    gzip
    jq
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
    (import ./scripts/change-volume.nix { inherit pkgs; })
    (import ./scripts/color-picker.nix { inherit pkgs; })
    (import ./scripts/powermenu.nix { inherit pkgs; })
    (import ./scripts/screenshot.nix { inherit pkgs; })
  ];
}
