{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [ 
    # this is handled by the kernel modules
    # broadcom-sta 
  ];
}
