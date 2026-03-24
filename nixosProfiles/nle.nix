{ config, lib, pkgs, inputs, unstablePkgs, ... }: {
  environment.systemPackages = (with pkgs; [
    #libsForQt5.kdenlive
    # (libsForQt5.kdenlive.overrideAttrs
    #   (_: previousAttrs: { version = "22.08.3"; }))
    kdePackages.kdenlive
    glaxnimate
    mediainfo
    mlt
    davinci-resolve-studio
    ffmpeg
  ]);
}
