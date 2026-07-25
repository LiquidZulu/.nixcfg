{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    hyfetch
    fastfetch
    onefetch
  ];
}
