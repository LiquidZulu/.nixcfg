{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ openai-whisper ];
}
