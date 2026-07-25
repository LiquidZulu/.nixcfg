{
  config,
  lib,
  pkgs,
  ...
}:
{

  programs.firejail.enable = true;

  environment.systemPackages = with pkgs; [

    protonup-ng
    protontricks

    # support both 32- and 64-bit applications
    wineWowPackages.stable
    wineWowPackages.waylandFull


    # winetricks (all versions)
    winetricks
  ];
}
