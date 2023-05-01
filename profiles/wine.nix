{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    protonup-ng
    protontricks

    # support both 32- and 64-bit applications
    wineWowPackages.stable

    # winetricks (all versions)
    winetricks
  ];
}
