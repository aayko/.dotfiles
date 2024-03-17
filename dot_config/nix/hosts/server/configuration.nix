{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  networking.hostName = "jinko";

  mynix.jellyfin.enable = true;
  mynix.syncthing.enable = true;

  environment.systemPackages = with pkgs; [
    xclip
    xsel
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8096 ];
  networking.firewall.allowedUDPPorts = [ ];

  environment.shellInit = ''
    if command -v tmux>/dev/null; then
      [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
        fi
  '';
}
