{
  config,
  lib,
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    waifu2x-converter-cpp
    #rembg
  ];
}
