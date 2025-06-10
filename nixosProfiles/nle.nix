{ config, lib, pkgs, ... }: {
  environment.systemPackages = (with pkgs; [
    #libsForQt5.kdenlive
    (libsForQt5.kdenlive.overrideAttrs
      (_: previousAttrs: { version = "22.08.3"; }))
    glaxnimate
    mediainfo
    mlt
    #davinci-resolve
    ffmpeg
  ]);
}
