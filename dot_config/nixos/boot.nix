{ config, pkgs, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  desktop = hostname == "nixpc\n";
  laptop = hostname == "nixlaptop\n";
in
{
  system.activationScripts.removeBootEntryVersion = {
    text = ''
      ${pkgs.findutils}/bin/find /boot/loader/entries/ -name 'nixos-generation-*' -exec ${pkgs.gnused}/bin/sed -i 's/version Generation \([0-9]*\).*/version \1/' {} \;
    '';
  };

  boot.blacklistedKernelModules = if laptop then [ "pcspkr" ] else [ ];
  boot.kernelParams = [ "quiet" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  systemd.watchdog.rebootTime = "0";

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.systemd-boot.extraEntries = {
    "arch.conf" =
      if desktop then ''
        title   Arch Linux
        linux   /EFI/arch/vmlinuz-linux
        initrd  /EFI/arch/intel-ucode.img
        initrd  /EFI/arch/initramfs-linux.img
        options root=/dev/disk/by-label/ARCHROOT zswap.enabled=0 rw rootfstype=ext4 quiet
      '' else ''
        title   Arch Linux
        linux   /EFI/arch/vmlinuz-linux
        initrd  /EFI/arch/amd-ucode.img
        initrd  /EFI/arch/initramfs-linux.img
        options root=/dev/disk/by-label/ARCHROOT rw rootfstype=ext4 quiet
      '';
  };
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;
}
