{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kdenlive mediainfo mlt ];
}
