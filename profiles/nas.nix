{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [ synology-drive-client ]; # this didnt work, I use flatpak now
}
