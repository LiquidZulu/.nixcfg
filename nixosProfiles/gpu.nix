{
  config,
  lib,
  pkgs,
  ...
}:

{
  # See https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [
    "nvidia" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
