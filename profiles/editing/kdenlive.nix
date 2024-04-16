{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    #libsForQt5.kdenlive
    (libsForQt5.kdenlive.overrideAttrs
      (_: previousAttrs: { version = "22.08.3"; }))
    glaxnimate
    mediainfo
    mlt
  ]);
  #
  #
  # ++ (
  #   # https://lazamar.co.uk/nix-versions/?package=kdenlive&version=22.08.3&fullName=kdenlive-22.08.3&keyName=libsForQt5.kdenlive&revision=6adf48f53d819a7b6e15672817fa1e78e5f4e84f&channel=nixos-22.11#instructions
  #   let
  #     nix_pkgs_with_kdenlive_22 = import (builtins.fetchGit {
  #       name = "kdenlive-22";
  #       url = "https://github.com/NixOS/nixpkgs/";
  #       ref = "refs/heads/nixos-22.11";
  #       rev = "7cf5ccf1cdb2ba5f08f0ac29fc3d04b0b59a07e4";
  #     }) { inherit (pkgs) system; };
  #   in [ nix_pkgs_with_kdenlive_22.kdenlive ])
  #
}
