{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gamescope
    steam
  ];
}
