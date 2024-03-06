{
  imports = [
    ./xserver.nix
    ./syncthing.nix
  ];

  services.openssh.enable = true;
  services.dbus.enable = true;
  services.sshd.enable = true;
  services.printing.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
