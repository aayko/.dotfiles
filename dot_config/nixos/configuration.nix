{ config, lib, pkgs, ... }:

let
  laptop = builtins.readFile "/etc/hostname" == "nixlaptop\n";
  commonImports = [
    ./resolved.nix
    ./boot.nix
    ./services.nix
    ./packages.nix
    ./environment.nix
    ./fonts.nix
    ./modules/ly.nix
  ];
in
{
  imports =
    if laptop then
      commonImports ++ [ ./host/laptop/hardware-configuration.nix ./host/laptop/capsLockRemap.nix ]
    else
      commonImports ++ [ ./host/desktop/hardware-configuration.nix ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/ayko/.config/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command flakes" ];
      auto-optimise-store = true;
    };
    gc.automatic = false;
    gc.dates = "19:00";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  networking.hostName = if laptop then "nixlaptop" else "nixpc"; # Define your hostname.

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

  programs.dconf.enable = true;

  programs.zsh = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ayko" ];
  };

  users.groups.plocate = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ayko = {
    isNormalUser = true;
    home = "/home/ayko";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

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
