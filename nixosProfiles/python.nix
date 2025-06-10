{
  config,
  lib,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    python311Full
    #python310Full
    #(python310.withPackages
    #  (ps: with ps; [ torch torchvision torchaudio-bin numpy ]))
  ];
}
