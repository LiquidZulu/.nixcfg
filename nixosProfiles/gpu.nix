{
  config,
  lib,
  pkgs,
  ...
}:

{
  # See "https://wiki.nixos.org/wiki/NVIDIA#Enabling"
  # TODO: This is proprietary, but we use the open source driver. Maybe we can remove this and use the default?
  services.xserver.videoDrivers = [
    "nvidia" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    #nvidia.package = null;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
    };
  };
}
