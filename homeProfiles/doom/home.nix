{
  inputs,
  cell,
  config,
  pkgs,
  lib,
}:
let
  inherit (inputs.home-manager.lib) hm;
in
{
  # Doom
  activation.installDoomEmacs = hm.dag.entryAfter [ "writeBoundary" ] ''
    export XDG_CONFIG_HOME="/home/liquidzulu/.config"
    if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
       ${lib.getExe pkgs.git} clone $VERBOSE_ARG --depth=1 --single-branch \
           "https://github.com/doomemacs/doomemacs.git" \
           "$XDG_CONFIG_HOME/emacs"
    fi
  '';

  sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];

  packages = with pkgs; [
    # Doom Dependencies
    git
    (ripgrep.override { withPCRE2 = true; })
    gnutls

    # Doom Optional Dependencies
    fd
    imagemagick
    zstd

    # Doom Module Dependencies
    ## :app
    ### everywhere
    xclip
    xdotool
    xorg.xprop
    xorg.xwininfo

    ## :checkers
    ### grammar
    languagetool

    ### spell
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    ## :tools
    ### lsp
    unzip
    python3Full
    nodejs
    nodePackages.npm
    nodePackages.prettier

    ## :lang
    ### cc
    gcc
    ccls

    ### common-lisp
    sbcl

    ### haskell
    ghc
    cabal-install
    ormolu
    haskellPackages.haskell-language-server
    haskellPackages.hoogle

    ### latex
    texlive.combined.scheme-full

    ### markdown
    mdl
    pandoc

    ### nix

    ### rust
    rustc
    cargo
    rustfmt
    rust-analyzer

    ### sh
    shfmt
    shellcheck

    ## :term
    ### eshell
    bash

    ## :tools
    ### direnv
    direnv

    ## :ui
    ### doom-dashboard
    emacs-all-the-icons-fonts
  ];

}
