{ config, pkgs, laptop, desktop, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  desktop = hostname == "nixpc";
  laptop = hostname == "nixlaptop";
  setupCommands = '';
      ${pkgs.playerctl}/bin/playerctld daemon &
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.polybar}/bin/polybar &
      ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/pictures/wallpapers/ghibli/5m5kLI9.png &
    '';

  myDmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = "https://github.com/aayko/dmenu/archive/main.tar.gz";
      sha256 = "1rg4m4pg3irkbnn40vmab2wqcalr96499lfkjb36w2p38crkarci";
    };
  });
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        polybar = pkgs.polybar.override {
          i3Support = true;
        };
        j4-dmenu-desktop = pkgs.j4-dmenu-desktop.override {
          dmenu = myDmenu;
        };
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "where_is_my_sddm_theme";
    };
    displayManager.setupCommands =
      if desktop then ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off
      '' else "";
    displayManager.sessionCommands =
      if desktop then setupCommands ++ ''
        ${pkgs.xorg.xset}/bin/xset s off -dpms
        ${pkgs.autorandr}/bin/autorandr --load desktop-default
      '' else setupCommands;
    xkb.layout = "pwerty";
    xkb.options = "compose:ralt,altwin:swap_lalt_lwin";
    autoRepeatDelay = 300;
    xkb.extraLayouts.pwerty = {
      description = "Modified qwerty for programming";
      languages = [ "eng" ];
      symbolsFile = /home/ayko/.config/xkb/symbols/pwerty;
    };
  };

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      polybar
      betterlockscreen
      autotiling
      feh
      maim
      xclip
      xcolor
      xclip
      xdotool
      xss-lock
      xsel
      (st.overrideAttrs (oldAttrs: {
        src = fetchurl {
          url = "https://github.com/aayko/st/archive/main.tar.gz";
          sha256 = "00wqqvxvjy8c8hiyf0qpznmdczglb7ac8ql28q7vik837s3gpiby";
        };
      }))
      j4-dmenu-desktop
      myDmenu
    ];
  };

  services.xserver.libinput = {
    mouse.accelProfile = "flat";
    enable = true;
    touchpad = {
      naturalScrolling = laptop;
      tapping = laptop;
    };
  };
}

