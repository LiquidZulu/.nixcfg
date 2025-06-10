{
  config,
  lib,
  pkgs,
  ...
}:
{
  # see https://download.ebz.epson.net/dsc/search/01/search/
  environment.systemPackages = with pkgs; [
    epson-escpr
    cups-filters
    ghostscript
  ];
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
  };
}
