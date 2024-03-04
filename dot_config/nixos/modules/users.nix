{ pkgs, ... }:

{
  users.groups.plocate = { };

  users.users.ayko = {
    isNormalUser = true;
    home = "/home/ayko";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
