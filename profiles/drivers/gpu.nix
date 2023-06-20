{ config, lib, pkgs, ... }:

{
  # See https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [
    "nvidia" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {

      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;

      # Use the open source version of the kernel module
      open = true;

      # Enable the nvidia settings menu
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
