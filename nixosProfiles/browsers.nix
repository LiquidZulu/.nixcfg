{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    chromium
    librewolf-bin
    tor-browser
    brave
    freetube
  ];
}
