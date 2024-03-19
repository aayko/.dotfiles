{ config, lib, pkgs, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix.steam.enable = lib.mkEnableOption "Setup steam";
  };

  config = lib.mkIf cfg.steam.enable {
    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    environment.systemPackages = with pkgs; [
      protontricks
      winetricks
    ];
  };
}
