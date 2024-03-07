{ pkgs, ... }:

{
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  security.pam.services.gnome_keyring = {
    text = ''
      auth     optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
      session  optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start

      password  optional    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so
    '';
  };

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
}
