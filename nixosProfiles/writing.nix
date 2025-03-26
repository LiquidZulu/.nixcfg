{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vscode
    vscodium
    libreoffice
    vim
    neovim
    obsidian
  ];
}
