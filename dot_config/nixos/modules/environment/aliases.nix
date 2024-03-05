{
  environment.shellAliases = {
    ne = "nvim ~/.config/nix/configuration.nix";
    ns = "sudo nixos-rebuild switch --flake ~/.config/nix\#default";
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
