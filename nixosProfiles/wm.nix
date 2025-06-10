{
  config,
  lib,
  pkgs,
  ...
}:
{

  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;

      # Enable KDE Plasma desktop environment
      desktopManager.plasma6.enable = true;
    
  };
}
