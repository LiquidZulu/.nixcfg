{ config, lib, pkgs, ... }:

{
  # See https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [
    "nouveau" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];
  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
}
