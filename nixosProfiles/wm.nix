{
  config,
  lib,
  pkgs,
  ...
}:
{

  services = {
    xserver = {

      # Enable X11 windowing system
      enable = true;

      # Enable KDE Plasma desktop environment
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };
}
