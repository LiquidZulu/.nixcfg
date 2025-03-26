{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ dt-shell-color-scripts ];
}
