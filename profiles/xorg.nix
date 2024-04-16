{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs.xorg; [ xmessage xhost ];
}
