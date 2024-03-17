{ config, pkgs, lib, ... }:

let
  cfg = config.mynix;
in
{
  options = {
    mynix._1password.enable = lib.mkEnableOption "Setup 1password";
  };

  config = lib.mkIf cfg._1password.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "ayko" ];
    };
  };
}
