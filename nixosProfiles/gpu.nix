{ config, lib, pkgs, ... }:

{
  # See https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [
    "nouveau" # https://github.com/NixOS/nixpkgs/issues/80936#issuecomment-1003784682
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia.package = null;
    # nvidia = {
    #   modesetting.enable = true;
    #   powerManagement = {
    #     enable = false;
    #     finegrained = false;
    #   };
    #   open = false;
    #   nvidiaSettings = true;
    #   package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #     version = "545.29.02";
    #     sha256_64bit =
    #       "sha256-RncPlaSjhvBFUCOzWdXSE3PAfRPCIrWAXyJMdLPKuIU="; # Verify hash
    #     sha256_aarch64 =
    #       "sha256-lZiNZw4dJw4DI/6CI0h0AHbreLm825jlufuK9EB08iw="; # Not needed for x86_64
    #     openSha256 = "sha256-lZiNZw4dJw4DI/6CI0h0AHbreLm825jlufuK9EB08iw=";
    #     settingsSha256 = "sha256-lZiNZw4dJw4DI/6CI0h0AHbreLm825jlufuK9EB08iw=";
    #     persistencedSha256 =
    #       "sha256-lZiNZw4dJw4DI/6CI0h0AHbreLm825jlufuK9EB08iw=";
    #   };

    # };
  };
}
