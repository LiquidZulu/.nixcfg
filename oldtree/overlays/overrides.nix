channels: final: prev: {
  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    discord
    element-desktop
    rage
    nix-index
    qutebrowser
    alejandra
    signal-desktop
    starship
    deploy-rs
    ;

  # haskellPackages = prev.haskellPackages.override (old: {
  #   overrides = prev.lib.composeExtensions (old.overrides or (_: _: { }))
  #     (hfinal: hprev:
  #       let version = prev.lib.replaceStrings [ "." ] [ "" ] prev.ghc.version;
  #       in {
  #         # same for haskell packages, matching ghc versions
  #         inherit (channels.latest.haskell.packages."ghc${version}")
  #           haskell-language-server;
  #       });
  # });

  # kdenlive = prev.libsForQt5.kdenlive.overrideAttrs (_: previousAttrs: {
  #   name = "kdenlive-22.08.3";
  #   version = "22.08.3";
  #   src = builtins.fetchTarball {
  #     url =
  #       "https://github.com/NixOS/nixpkgs/archive/6adf48f53d819a7b6e15672817fa1e78e5f4e84f.tar.gz";
  #     sha256 = "0p7m72ipxyya5nn2p8q6h8njk0qk0jhmf6sbfdiv4sh05mbndj4q";
  #   };
  # });

  # kdenlive = prev.libsForQt5.kdenlive.overrideAttrs (old: rec {
  #   name = "kdenlive-22.08.3";
  #   src = builtins.fetchTarball {
  #     url =
  #       "https://github.com/NixOS/nixpkgs/archive/6adf48f53d819a7b6e15672817fa1e78e5f4e84f.tar.gz";
  #   };
  # });

  # libsForQt5.kdenlive = prev.libsForQt5.kdenlive.overrideDerivation (oldAttrs: {
  #   src = builtins.fetchgit {
  #     # Descriptive name to make the store path easier to identify
  #     name = "kdenlive-working-revision";
  #     url = "https://github.com/NixOS/nixpkgs/";
  #     ref = "refs/heads/nixpkgs-unstable";
  #     rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
  #   };
  # });
  #blender = prev.blender.override { cudaSupport = true; };
}
