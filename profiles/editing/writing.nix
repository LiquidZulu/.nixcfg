{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    atom
    vscode
    vscodium
    libreoffice
    vim
    neovim
    obsidian
  ];
}
