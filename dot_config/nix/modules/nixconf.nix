{ inputs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command flakes" ];
      use-xdg-base-directories = true;
    };
    gc.automatic = true;
    gc.dates = "19:00";
  };

  nixpkgs = {
    overlays = [
      (final: _prev: {
        stable = import inputs.nixpkgs-stable {
          system = final.system;
          config.allowUnfree = true;
        };
      })
    ];
    config.allowUnfree = true;
  };
}
