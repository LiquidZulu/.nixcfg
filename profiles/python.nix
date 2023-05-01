{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs;
    [
      #python310Full
      #(python310.withPackages
      #  (ps: with ps; [ torch torchvision torchaudio-bin numpy ]))
    ];
}
