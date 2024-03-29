{ pkgs, lib, config, ... }:

{
  options = {
    mynix.bootConfig.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Setup boot config";
    };
  };

  config = lib.mkIf config.mynix.bootConfig.enable {
    system.activationScripts = {
      removeBootEntryVersion = {
        text = ''
          ${pkgs.findutils}/bin/find /boot/loader/entries/ -name 'nixos-generation-*' -exec ${pkgs.gnused}/bin/sed -i 's/version Generation \([0-9]*\).*/title NixOS - Generation \1/' {} \;
          ${pkgs.findutils}/bin/find /boot/loader/entries/ -name 'nixos-generation-*' -exec ${pkgs.gnused}/bin/sed -i '1d' {} \;
        '';
      };
    };

    boot.kernelParams = [ "quiet" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];

    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
    boot.initrd.systemd.enable = true;
    systemd.watchdog.rebootTime = "0";

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.timeout = 0;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
