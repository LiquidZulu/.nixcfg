{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs;
    [
      python314Full
      #python310Full
      #(python310.withPackages
      #  (ps: with ps; [ torch torchvision torchaudio-bin numpy ]))
    ];
}
