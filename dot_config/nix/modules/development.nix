{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # haskell
    ghc
    haskellPackages.haskell-language-server
    # php
    php
    nodePackages_latest.intelephense
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
