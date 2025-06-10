{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alsa-lib
    alsa-oss
    alsa-utils
    alsa-tools
    mpg123
  ];
}
