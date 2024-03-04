{
  nix = {
    settings = {
      experimental-features = [ "nix-command flakes" ];
      auto-optimise-store = true;
    };
    gc.automatic = false;
    gc.dates = "19:00";
  };

  nixpkgs.config.allowUnfree = true;
}
