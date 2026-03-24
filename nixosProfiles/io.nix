{
  config,
  lib,
  pkgs,
  unstablePkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    gscan2pdf
    xsane
    sane-frontends
    sane-backends
    unstablePkgs.scrcpy
    android-tools
  ];
}
