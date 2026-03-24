{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    discord
    vesktop
    zoom-us
    slack
  ];
}
