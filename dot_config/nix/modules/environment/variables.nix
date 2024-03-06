{
  environment.variables = rec {
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    PATH = [
      "${XDG_BIN_HOME}"
    ];

    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    BROWSER = "firefox";
    TERM = "st-256color";
    TERMINAL = "st";
    GTK_THEME = "Colloid-Grey-Dark";

    GTK_CSD = "0";
    GHCUP_USE_XDG_DIRS = "true";
    STACK_XDG = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";

    GTK2_RC_FILES = "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    ANDROID_HOME = "${XDG_DATA_HOME}/android";
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
    XCOMPOSECACHE = "${XDG_CACHE_HOME}/X11/xcompose";
    NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/npmrc";
    RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    WORDCHARS = "";
    ERRFILE = "${XDG_CACHE_HOME}/X11/xsession-errors";
    BEMENU_OPTS = "--tb '#242424'\
   --tf '#FFFFFF'\
   --fb '#242424'\
   --ff '#FFFFFF'\
   --nb '#242424'\
   --nf '#FFFFFF'\
   --hb '#FFFFFF'\
   --hf '#242424'\
   --sb '#E1FAFF'\
   --cb '#E1FAFF'\
   --cf '#FFFFFF'\
   --sf '#FFFFFF'\
   --sb '#E1FAFF'\
   --ab '#242424'\
   --af '#FFFFFF'\
   --scb '#242424'\
   --bdr '#242424'\
   --scf '#FFFFFF'\
   --hp 10\
   -B 6'";
  };
}
