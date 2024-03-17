{ pkgs, ... }:

{
  imports = [
    ./network
    ./environment
    ./boot.nix
    ./packages.nix
    ./users.nix
    ./development.nix
    ./nixConfig.nix
  ];

  system.activationScripts = {
    symlinkRootConfig = {
      text = ''
        if [ ! -L /root/.config ]; then
          ln -s /home/ayko/.config /root/.config
            fi
      '';
    };
    copyBashrcToRoot = {
      text = ''
        if [ ! -e /root/.bashrc ]; then
          cp /home/ayko/.bashrc /root/.bashrc
            fi
      '';
    };
  };

  console = {
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
    useXkbConfig = true;
  };

  time.timeZone = "Europe/Paris";
}
