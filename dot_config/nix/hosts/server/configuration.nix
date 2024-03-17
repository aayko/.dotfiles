{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../modules
    ../../modules/syncthing
  ];

  networking.hostName = "jinko";

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
