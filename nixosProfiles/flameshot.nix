{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    flameshot
    #watershot
    grim
    ksnip
  ];
}
