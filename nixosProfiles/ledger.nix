{
  config,
  lib,
  pkgs,
  services,
  ...
}:

{
  environment.systemPackages = with pkgs; [ ledger-live-desktop ];

  # Required for Ledger Live to detect Ledger Nano S via USB
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="*", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="*", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  '';
}
