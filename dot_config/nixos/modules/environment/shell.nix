{
  environment.shellAliases = {
    ne = "nvim $XDG_CONFIG_HOME/nixos/configuration.nix";
    ns = "sudo nixos-rebuild switch -I nixos-config=/home/ayko/.config/nixos/configuration.nix |& nom";
    svn = "svn --config-dir $XDG_CONFIG_HOME/subversion";
    wget = "wget --hsts-file=$XDG_DATA_HOME/wget-hsts";
    adb = "HOME=$ANDROID_HOME adb";
  };

  environment.shellInit = ''
    nl() {
      nix-locate /bin/"$1" | grep -v "(.*)" | awk -F '.out' '{ print $1 }'
    }
  '';
}
