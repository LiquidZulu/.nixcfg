{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    rustc
    rust-analyzer
    rustup
    cargo-binstall
  ];
}
