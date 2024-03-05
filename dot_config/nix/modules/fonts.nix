{ pkgs, ... }:

{
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
}
