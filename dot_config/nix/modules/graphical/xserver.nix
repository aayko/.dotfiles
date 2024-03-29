{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.xserver.enable = lib.mkEnableOption "Setup xserver";
  };

  config = lib.mkIf cfg.xserver.enable {
    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      displayManager = {
        sddm = {
          enable = true;
          theme = "where_is_my_sddm_theme";
        };
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          autotiling
          betterlockscreen
          (j4-dmenu-desktop.override {
            dmenu = bemenu;
          })
          bemenu
          maim
          picom
          (polybar.override {
            i3Support = true;
          })
          xdo
          (st.overrideAttrs (oldAttrs: {
            src = pkgs.fetchFromGitHub {
              owner = "aayko";
              repo = "st";
              rev = "main";
              hash = "sha256-7bhZwsJWJbJT2+yG8FC1acnuaAABckQ0iuAnXXh5gHs=";
            };
          }))
          xclip
          xsel
          xcolor
          xdotool
          xss-lock
        ];
      };

      displayManager.sessionCommands = ''
        ${pkgs.playerctl}/bin/playerctld daemon &
        ${pkgs.dunst}/bin/dunst &
        ${pkgs.xbanish}/bin/xbanish &
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/.config/i3/wallpaper.png
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
      autoRepeatInterval = 30;

      libinput = {
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
        };
        enable = true;
      };
    };
  };
}
