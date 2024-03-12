{
  nix = {
    settings = {
      experimental-features = [ "nix-command flakes" ];
      use-xdg-base-directories = true;
    };
    gc.automatic = true;
    gc.dates = "19:00";
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      stable = import
        (fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz";
          sha256 = "sha256:1gvricg9hinsc399d76im9vn3wjn34wcmfzfflwyz9yhr5npcr4b";
        })
        { };
    };
  };
}
