{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "screenshot";
  runtimeInputs = with pkgs; [ maim xclip libnotify xdotool ];
  text = ''
    time=$(date -u "+%s" | cut -c 7-)
    file="Screenshot-$(date -u +%d-%m-%Y-"$time").png"
    folder="$(xdg-user-dir SCREENSHOTS)/"

    function copy_image() {
        xclip -sel clipboard -target image/png < "$folder$file"
    }

    function send_notification() {
        notify-send --icon "$folder$file" "Screenshot saved" "You can paste the image from the clipboard"
    }

    function region() {
        if [[ $XDG_SESSION_TYPE == "x11" ]]; then
            maim --select -u "$folder$file" && copy_image
        else
            hyprshot -o "$folder" -f "$file" -m region -s
        fi && send_notification
    }

    function window() {
        if [[ $XDG_SESSION_TYPE == "x11" ]]; then
            maim -u --window "$(xdotool getactivewindow)" "$folder$file" && copy_image
        else
            hyprshot -o "$folder" -f "$file" -m window -sc
        fi && send_notification
    }

    function monitor() {
        if [[ $XDG_SESSION_TYPE == "x11" ]]; then
            maim -g 1920x1080+0+0 -u "$folder$file" && copy_image
        else
            hyprshot -o "$folder" -f "$file" -m output -sc
        fi && send_notification
    }

    doc() {
        echo "Usage:
        screenshot [Options]

        Options:
        region       Screenshots the selected area
        window     Screenshots the focussed window
        monitor     Screenshots the focussed display"
    }

    case $1 in 
        region) region      ;;
        window) window      ;;
        monitor) monitor    ;;
        *) doc              ;;
    esac
  '';
}
