{
  config,
  lib,
  pkgs,
  ...
}:
{

  services = {
    displayManager.sddm.enable = true;
    xserver = {

      # Enable X11 windowing system
      enable = true;

      # Enable KDE Plasma desktop environment
      desktopManager.plasma5.enable = true;
    };
  };
}
