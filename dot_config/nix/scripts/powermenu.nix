{ pkgs, ... }:

let
  hostname = builtins.readFile "/etc/hostname";
  desktop = hostname == "nixpc\n";

  dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "aayko";
      repo = "dmenu";
      rev = "main";
      hash = "sha256-WOZvw3Pb5JX0osIgqcyw6SANfxBYAQAhy6L/XHiQXoU=";
    };
  });

  lock = import ./lock.nix { inherit pkgs; };
in
pkgs.writeShellApplication {
  name = "powermenu";
  runtimeInputs = with pkgs; [ dmenu lock ];
  text = ''
    lock="lock"
    hibernate="hibernate"
    shutdown="shutdown"
    reboot="reboot"
    windows="windows"
    arch="arch"

    if ${if desktop then "true" else "false"}; then
      options="$shutdown\n$reboot\n$windows\n$arch"
    else
      options="$lock\n$hibernate\n$shutdown\n$reboot\n$arch"
    fi
    chosen="$(echo -e "$options" | dmenu)"
    case $chosen in
        "$lock")
            lock
            ;;
        "$shutdown")
            systemctl poweroff
            ;;
        "$hibernate")
            systemctl hibernate
            lock
            ;;
        "$reboot")
            systemctl --no-wall reboot
            ;;
        "$windows")
            systemctl --no-wall reboot --boot-loader-entry=auto-windows
            ;;
        "$arch")
            systemctl --no-wall reboot --boot-loader-entry=arch.conf
            ;;
    esac
  '';
}
