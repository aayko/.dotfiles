{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "where_is_my_sddm_theme";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
      ];
    };

    displayManager.sessionCommands = ''
      ${pkgs.playerctl}/bin/playerctld daemon &
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.xbanish}/bin/xbanish &
    '';

    xkb = {
      layout = "pwerty";
      variant = "";
      model = "";
      options = "compose:ralt,altwin:swap_lalt_lwin";
      extraLayouts.pwerty = {
        description = "Modified qwerty for programming";
        languages = [ "eng" ];
        symbolsFile = ../../assets/pwerty;
      };
    };

    autoRepeatDelay = 200;
    autoRepeatInterval = 33;

    libinput = {
      mouse.accelProfile = "flat";
      enable = true;
    };
  };
}
