{ config, lib, pkgs, ... }:

let
  myDmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      url = "https://github.com/aayko/dmenu/archive/main.tar.gz";
      sha256 = "1rg4m4pg3irkbnn40vmab2wqcalr96499lfkjb36w2p38crkarci";
    };
  });
in
{
    services.xserver = {
        windowManager.i3 = {
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
    };
}
