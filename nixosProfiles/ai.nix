{ config, lib, pkgs, comfyui-nix, ... }:

{
  environment.systemPackages = with pkgs; [ grok-cli ];

  nixpkgs.overlays = [ comfyui-nix.overlays.default ];

  services.comfyui = {
    enable = true;
    gpuSupport = "cuda";          # you already have NVIDIA + cuda profile
    enableManager = true;         # useful for extra nodes the plugin may want
    # dataDir = "/var/lib/comfyui";  # default is fine, or put it under your home
    # user = "liquidzulu";
    # group = "users";
    # createUser = false;
    # port = 8188;
    listenAddress = "127.0.0.1";
    openFirewall = false;
  };
}
