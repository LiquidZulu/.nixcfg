
{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [ chromium librewolf tor-browser-bundle-bin ];
}
