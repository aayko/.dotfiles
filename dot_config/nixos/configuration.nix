# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            ./resolved.nix
        ];

    nix.nixPath = [
        "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
        "nixos-config=/home/ayko/.config/nixos/configuration.nix"
        "/nix/var/nix/profiles/per-user/root/channels"
    ];

    system.activationScripts.removeBootEntryVersion = {
        text = ''
        ${pkgs.findutils}/bin/find /boot/loader/entries/ -name 'nixos-generation-*' -exec ${pkgs.gnused}/bin/sed -i 's/version Generation \([0-9]*\).*/version \1/' {} \;
        '';
    };
    boot.kernelParams = [ "quiet" ];
    boot.supportedFilesystems = [ "ntfs" ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.systemd-boot.extraEntries = {
        "arch.conf" = ''
            title   Arch Linux
            linux   /EFI/arch/vmlinuz-linux
            initrd  /EFI/arch/intel-ucode.img
            initrd  /EFI/arch/initramfs-linux.img
            options root=/dev/disk/by-label/ARCHROOT zswap.enabled=0 rw rootfstype=ext4 quiet
        '';
    };
    boot.loader.timeout = 0;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.plymouth.enable = false;

    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            auto-optimise-store = true;
        };
        gc.automatic = false;
        gc.dates = "19:00";
    };

    networking.hostName = "nixpc"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;    # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    console = {
        packages = with pkgs; [ terminus_font ];
        font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
        useXkbConfig = true; # use xkb.options in tty.
    };

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    hardware.bluetooth.enable = true;
    services.dbus.enable = true;
    services.picom.enable = true;
    services.sshd.enable = true;
    services.udisks2.enable = true;

    services.xserver = {
        enable = true;
        # displayManager.ly = {
        #     enable = true;
        #     defaultUser = "ayko";
        # };
        videoDrivers = [ "nvidia" ];
        displayManager.sddm = {
            enable = true;
            theme = "where_is_my_sddm_theme";
        };
        displayManager.setupCommands = ''
            ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --off
        '';
        displayManager.sessionCommands = ''
            ${pkgs.xorg.xset}/bin/xset s off -dpms
            ${pkgs.autorandr}/bin/autorandr --load desktop-default
            ${pkgs.playerctl}/bin/playerctld daemon &
            ${pkgs.dunst}/bin/dunst &
            ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ~/pictures/wallpapers/ghibli/5m5kLI9.png &
        '';
        windowManager.i3 = {
            enable = true;
            extraPackages = with pkgs; [
                polybar
                betterlockscreen
                autotiling
                feh
                maim
                xclip
                xcolor
                xclip
                xdotool
                xss-lock
                xsel
                (st.overrideAttrs (oldAttrs: {
                    src = fetchurl {
                      url = "https://github.com/aayko/st/archive/main.tar.gz";
                      sha256 = "00wqqvxvjy8c8hiyf0qpznmdczglb7ac8ql28q7vik837s3gpiby";
                    };
                }))
                j4-dmenu-desktop
                (dmenu.overrideAttrs (oldAttrs: {
                    src = fetchurl {
                      url = "https://github.com/aayko/dmenu/archive/main.tar.gz";
                      sha256 = "1rg4m4pg3irkbnn40vmab2wqcalr96499lfkjb36w2p38crkarci";
                    };
                }))
            ];
        };
        xkb.layout = "pwerty";
        xkb.options = "compose:ralt,altwin:swap_lalt_lwin";
        autoRepeatDelay = 300;
        xkb.extraLayouts.pwerty = {
            description = "Modified qwerty for programming";
            languages = [ "eng" ];
            symbolsFile = /home/ayko/.config/xkb/symbols/pwerty;
        };
    };

    environment.variables = rec {
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";
        XDG_BIN_HOME    = "$HOME/.local/bin";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME  = "$HOME/.cache";
        PATH = [
            "${XDG_BIN_HOME}"
        ];

        EDITOR = "nvim";
        VISUAL = "nvim";
        MANPAGER = "nvim +Man!";
        BROWSER = "firefox";
        TERMINAL = "xdg-terminal-exec";
        GTK_THEME = "Colloid-Grey-Dark:dark";

        GTK_CSD = "0";
        GHCUP_USE_XDG_DIRS = "true";
        STACK_XDG = "1";
        __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";

        GTK2_RC_FILES = "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
        ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
        ANSIBLE_HOME = "${XDG_DATA_HOME}/ansible";
        CARGO_HOME = "${XDG_DATA_HOME}/cargo";
        CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
        GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";
        NIMBLE_DIR = "${XDG_DATA_HOME}/nimble";
        STACK_ROOT = "${XDG_DATA_HOME}/stack";
        TEXMFVAR = "${XDG_CACHE_HOME}/texlive/texmf-var";
        WINEPREFIX = "${XDG_DATA_HOME}/wine";
        GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
        CABAL_DIR = "${XDG_DATA_HOME}/cabel";
        CABAL_CONFIG = "${XDG_CONFIG_HOME}/cabal/config";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=\"${XDG_CONFIG_HOME}/java\"";
        ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
        XCOMPOSEFILE = "${XDG_CONFIG_HOME}/xcompose";
        XCOMPOSECACHE="${XDG_CACHE_HOME}/X11/xcompose";
        NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
        RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    };

    environment.shellAliases = {
        dot = "${pkgs.chezmoi}/bin/chezmoi";
        se = "sudoedit";
        ne = "v /etc/nixos/configuration.nix";
        ns = "sudo nixos-rebuild switch";
        v = "${pkgs.neovim}/bin/nvim";
        svn = "svn --config-dir $HOME/.config/subversion";
        wget = "wget --hsts-file=$HOME/.local/share/wget-hsts";
        adb = "HOME=${config.environment.variables.ANDROID_USER_HOME} adb";
    };

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.xserver.libinput = {
        mouse.accelProfile = "flat";
        enable = true;
        touchpad = {
            naturalScrolling = true;
            tapping = true;
        };
    };

    programs.zsh = {
        enable = true;
        # autosuggestions.enable = true;
        # enableCompletion = true;
        # enableGlobalCompInit = true;
        # histFile = "${config.environment.variables.ZDOTDIR}/history";
        # histSize = 50000;
        # setOptions = [
        #     "autocd"
        #     "globdots"
        #     "nobeep"
        #     "nomatch"
        #     "menucomplete"
        #     "extendedglob"
        #     "interactivecomments"
        #     "appendhistory"
        #     "histignorespace"
        #     "histignoredups"
        #     "banghist"
        #     "extendedhistory"
        #     # "incappendhistory"
        #     # "sharehistory"
        #     "histexpiredupsfirst"
        #     "histignoredups"
        #     "histignorealldups"
        #     "histfindnodups"
        #     "histignorespace"
        #     "histsavenodups"
        #     "histreduceblanks"
        #     "histverify"
        # ];
    };

    programs._1password.enable = true;
    programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "ayko" ];
    };

    programs.firefox = {
        enable = true;
    };

    users.groups.plocate = {};

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ayko = {
        isNormalUser = true;
        home = "/home/ayko";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            packageOverrides = pkgs: {
                unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
                polybar = pkgs.polybar.override {
                  i3Support = true;
                };
            };
        };
    };

    fonts.fontconfig = {
        enable = true;
        defaultFonts = {
            monospace = [ "FiraCode Nerd Font" "Mononoki Nerd Font" ];
            sansSerif = [ "Ubuntu Nerd Font" ];
        };
    };
    fonts.packages = with pkgs; [
        font-awesome
        (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" "Ubuntu" ]; })
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
    ];

    xdg.portal = {
        enable = true;
        config.common.default = "*";
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    security.polkit.enable = true;

    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = ["graphical-session.target"];
            wants = ["graphical-session.target"];
            after = ["graphical-session.target"];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };

    environment.systemPackages = with pkgs; [
        neovim
        fzf
        ly
        wget
	    chezmoi
        git
        rustup
        nodejs
        gcc
        lf
        dunst
        libnotify
        unzip
        age
        ansible
        jq
        gzip
        bc
        btop
        colordiff
        cron
        dict
        gnumake
        plocate
        ripgrep
        sassc
        socat
        sshfs-fuse
        gnutar
        transmission
        udiskie
        tree
        zip
        autorandr
        spotifyd
        ncspot
        ueberzugpp
        zathura
        xdg-user-dirs
        vesktop
        ungoogled-chromium
        speechd
        gnome.seahorse
        scrcpy
        qbittorrent
        polkit
        polkit_gnome
        obs-studio
        mimeo
        mpv
        unstable.melonDS
        mdcat
        imv
        gtk-engine-murrine
        gthumb
        colloid-icon-theme
        gnome-themes-extra
        libgnome-keyring
        gnome.gnome-disk-utility
        gnome.gnome-calculator
        fontforge
        ffmpeg
        ffmpegthumbnailer
        ctpv
        celluloid
        bat
        atool
        _1password-gui
        unstable.xdg-terminal-exec
        trash-cli
        nim
        nimPackages.nimble
        (where-is-my-sddm-theme.override {
            themeConfig.General = {
                cursorColor = "#ffffff";
                passwordCharacter = "*";
            };
        })
        (vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions; [
                bbenoist.nix
                jdinhlife.gruvbox
                vscodevim.vim
                github.copilot
                github.copilot-chat
            ];
        })
        pamixer
        # sddm
        # libsForQt5.qt5.qtgraphicaleffects
        # libsForQt5.qt5.qtquickcontrols
        # libsForQt5.qt5.qtquickcontrols2
        # qt6.qtdeclarative
        # snappy
        # swayidle
        # swaylock-effects
        pinentry-gnome
        gpgme
        libgcrypt
        libassuan
        tldr
        # haskellPackages.ghcup
        xdg-ninja
        gnome.gnome-weather
        gnome.nautilus
        nitch
        playerctl
        home-manager
        killall
        # blueberry
        bluetuith
        ntfs3g
        gparted
        # end
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        pinentryFlavor = "gnome3";
        enableSSHSupport = true;
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # do not change   
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "23.11"; # Did you read the comment?

}

