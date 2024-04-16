{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    audiowaveform
    alsa-lib
    alsa-oss
    alsa-utils
    alsa-tools
    mpg123
  ];
}
