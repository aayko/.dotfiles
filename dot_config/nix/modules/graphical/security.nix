{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.security.enable = lib.mkEnableOption "Setup keyring and polkit";
  };

  config = lib.mkIf cfg.security.enable {
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
    programs.seahorse.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.gnome-keyring
      polkit_gnome
    ];

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
  };
}
