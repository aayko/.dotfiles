{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font" "Mononoki Nerd Font" ];
      sansSerif = [ "Ubuntu Nerd Font" ];
    };
  };
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" "Ubuntu" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}
