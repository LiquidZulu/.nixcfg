{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gscan2pdf
    xsane
    sane-frontends
    sane-backends
  ];
}
