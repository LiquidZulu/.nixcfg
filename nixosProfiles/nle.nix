{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      kdePackages.kdenlive
      glaxnimate
      mediainfo
      mlt
      #davinci-resolve
      ffmpeg
    ]
  );
}
