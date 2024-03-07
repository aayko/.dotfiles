{ pkgs, ... }:

{
  environment.shellAliases = {
    ne = "cd $HOME/.config/nix; ${pkgs.neovim}/bin/nvim .";
    ns = "${pkgs.nh}/bin/nh os switch";
    nh = "${pkgs.nh}/bin/nh search";
    svn = "svn --config-dir $XDG_CONFIG_HOME/subversion";
    wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
    adb = "HOME=$ANDROID_HOME adb";
  };

  environment.shellInit = ''
    nl() {
      ${pkgs.nix-index}/bin/nix-locate /bin/"$1" | grep -v "(.*)" | awk -F '.out' '{ print $1 }'
    }
    d() {
        nohup $1 > /dev/null &
    }
  '';
}
