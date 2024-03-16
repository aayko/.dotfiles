{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../modules
  ];

  networking.hostName = "jinko";

  environment.systemPackages = with pkgs; [
    xclip
    xsel
  ];

  environment.shellInit = ''
    if command -v tmux>/dev/null; then
      [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
        fi
  '';
}
