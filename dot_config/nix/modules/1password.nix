{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ayko" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        librewolf
      '';
      mode = "0755";
    };
  };
}
