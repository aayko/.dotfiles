{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # haskell
    ghc
    haskellPackages.haskell-language-server
    # php
    php
    nodePackages.intelephense
    nodePackages.browser-sync
    # latex
    texlab
    texliveMedium
    # nix
    nil
    nixpkgs-fmt
    # java
    zulu
    ant
    # shell
    shellcheck
    nodePackages.bash-language-server
    # lua
    lua-language-server
    stylua

    python3
    tree-sitter
    clang-tools
    taplo
  ];
}
