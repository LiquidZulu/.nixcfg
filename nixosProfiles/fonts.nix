{ config, lib, pkgs, ... }: {

  # environment.systemPackages = with pkgs.nerd-fonts; [
  #   mononoki
  #   lilex
  #   _3270
  #   monoid
  #   go-mono
  #   symbols-only
  # ];

  #environment.systemPackages = with pkgs; [ nerdfonts ];

  fonts.packages = [ ] ++ builtins.filter lib.attrsets.isDerivation
    (builtins.attrValues pkgs.nerd-fonts);

  # environment.systemPackages = [ pkgs.nerd-fonts."m+" ]
  #   ++ (with pkgs.nerd-fonts; [
  #     mononoki
  #     lilex
  #     _3270
  #     monoid
  #     go-mono
  #     symbols-only
  #   ]);
}
