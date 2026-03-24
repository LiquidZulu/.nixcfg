{ config, lib, pkgs, ... }:

{
  unstablePkgs.overlays = [
    (self: super: {
      gjs = super.gjs.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs or [] ++ [ pkgs.glibcLocales ];
        preCheck = ''
          export HOME=/build/tmp
          mkdir -p $HOME
          export HISTFILE=/build/tmp/.history
          touch $HISTFILE
          chmod 600 $HISTFILE
          export LANG=C.UTF-8
        '';
      });
    })
  ];
}
