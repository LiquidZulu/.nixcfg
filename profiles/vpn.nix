{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [ protonvpn-gui ];
}
