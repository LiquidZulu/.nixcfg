{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [ yt-dlp ];
}
