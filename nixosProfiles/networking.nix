{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    websocat
    #wrangler
    nethogs
    # this is handled by the kernel modules
    # broadcom-sta
  ];
}
