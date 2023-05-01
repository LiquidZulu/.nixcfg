{ config, lib, pkgs, services, ... }:

{
  environment.systemPackages = with pkgs; [ mpv ];
}
