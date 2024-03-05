{ pkgs, dmenu, ... }:

let
  lock = import ./lock.nix { inherit pkgs; };
in
pkgs.writeShellApplication {
  name = "powermenu";
  runtimeInputs = with pkgs; [ dmenu lock ];
  text = ''
    lock="lock"
    suspend="suspend"
    hibernate="hibernate"
    shutdown="shutdown"
    reboot="reboot"
    windows="windows"

    if [[ -d /sys/class/power_supply/BAT0 ]]; then
      options="$lock\n$suspend\n$hibernate\n$shutdown\n$reboot"
    else
      options="$shutdown\n$reboot\n$windows"
    fi
    chosen="$(echo -e "$options" | dmenu)"
    case $chosen in
        "$lock")
            lock
            ;;
        "$suspend")
            systemctl suspend
            lock
            ;;
        "$hibernate")
            systemctl hibernate
            lock
            ;;
        "$shutdown")
            systemctl poweroff
            ;;
        "$reboot")
            systemctl --no-wall reboot
            ;;
        "$windows")
            systemctl --no-wall reboot --boot-loader-entry=auto-windows
            ;;
    esac
  '';
}
