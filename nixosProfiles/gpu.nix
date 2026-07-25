{ config, lib, pkgs, ... }:

{
  # See https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
    clinfo
    opencl-clhpp
    ocl-icd
  ];

  hardware = {

    opengl.extraPackages = with pkgs; [
      opencl-clhpp
      ocl-icd
    ];

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
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:11@0:0:0";
        nvidiaBusId  = "PCI:1@0:0:0";
      };
    };
  };
}
