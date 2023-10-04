# { config, lib, pkgs, ... }: {
#  outputs = { self, nixpkgs, blender-bin }: {
#    nixosConfigurations.bla = nixpkgs.lib.nixosSystem {
#      system = "x86_64-linux";
#      modules = [
#        ({ config, pkgs, ... }: {
#          nixpkgs.overlays = [ blender-bin.overlay ];
#          environment.systemPackages = [ pkgs.blender ];
#        })
#      ];
#    };
#  };
#}

{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [ (blender.override { cudaSupport = false; }) ];
  # https://github.com/NixOS/nixpkgs/issues/7582
  #nixpkgs.config.packageOverrides = self: rec {
  #  blender = self.blender.override { cudaSupport = true; };
  #};

  # https://discourse.nixos.org/t/how-to-get-cuda-working-in-blender/5918/3
  #nixpkgs = {
  #  overlays = [
  #    (final: prev: {
  #      blender = prev.blender.override { cudaSupport = true; };
  #    })
  #  ];
  #};
}
