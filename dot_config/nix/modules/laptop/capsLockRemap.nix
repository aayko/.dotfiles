{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.remapCapsLock.enable = lib.mkEnableOption ''
      Remaps caps lock to escape on tap and ctrl on hold
    '';
  };

  config = lib.mkIf cfg.remapCapsLock.enable {
    environment.etc."dual-function-keys.yaml".text = ''
      MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTCTRL
    '';
    services.interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
  };
}
