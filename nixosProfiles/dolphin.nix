{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ kdePackages.dolphin ];
}
