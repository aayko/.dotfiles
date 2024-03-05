{ pkgs, ... }:

{
  users.groups.plocate = { };

  users.users.ayko = {
    isNormalUser = true;
    home = "/home/ayko";
    initialPassword = "pw123";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
