{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
  ];
}
