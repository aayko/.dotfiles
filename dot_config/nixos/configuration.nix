{ config, lib, pkgs, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  desktop = hostname == "nixpc";
  laptop = hostname == "nixlaptop";
  commonImports = [
    ./resolved.nix
    ./boot.nix
    ./xserver.nix
    ./packages.nix
    ./environment.nix
    ./fonts.nix
  ];
in
{
  imports =
    if desktop then
      commonImports ++ [ ./desktop/hardware-configuration.nix ]
    else
      commonImports ++ [ ./laptop/hardware-configuration.nix ./laptop/capsLockRemap.nix ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/ayko/.config/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc.automatic = false;
    gc.dates = "19:00";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  networking.hostName = if desktop then "nixpc" else "nixlaptop"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.brillo.enable = laptop;
  hardware.bluetooth.enable = true;

  services.openssh.enable = true;
  services.dbus.enable = true;
  services.sshd.enable = true;
  services.printing.enable = true;

  services.picom.enable = true;
  services.udisks2.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="amdgpu_bl0", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '/home/ayko/.local/bin/charging-notify 0'"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ayko/.Xauthority" RUN+="${pkgs.su}/bin/su ayko -c '/home/ayko/.local/bin/charging-notify 1'"
  '';

  programs.zsh = {
    enable = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ayko" ];
  };

  programs.firefox = {
    enable = true;
  };

  users.groups.plocate = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ayko = {
    isNormalUser = true;
    home = "/home/ayko";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   config.common.default = "*";
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # security.polkit.enable = true;

  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   pinentryFlavor = "gnome3";
  #   enableSSHSupport = true;
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # do not change   
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

