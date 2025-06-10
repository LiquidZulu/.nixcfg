{ config, lib, pkgs, ... }: {

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
