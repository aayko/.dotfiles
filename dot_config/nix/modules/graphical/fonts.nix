{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.fontConfig.enable = lib.mkEnableOption "Setup fonts";
  };

  config = lib.mkIf cfg.fontConfig.enable {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Inconsolata Nerd Font" ];
        sansSerif = [ "Ubuntu Nerd Font" ];
      };
    };
    fonts.packages = with pkgs; [
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" "Ubuntu" "Inconsolata" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}
