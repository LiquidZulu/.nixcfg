{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    chromium
    firefox-bin
    tor-browser
    brave
    freetube
  ];
}
