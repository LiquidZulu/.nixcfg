{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      dnsutils
      fd
      git
      bottom
      jq
      # manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      whois
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ];

    shellAliases = {
      # quick cd
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # git
      g = "git";

      # grep
      grep = "rg";
      gi = "grep -i";

      # sudo
      s = "sudo -E ";
      si = "sudo -i";
      se = "sudoedit";

      # nix
      n = "nix";
      np = "n profile";
      ni = "np install";
      nr = "np remove";
      nrb = "sudo nixos-rebuild";
      ns = "n search --no-update-lock-file";
      nf = "n flake";
      nepl = "n repl '<nixpkgs>'";
      srch = "ns nixos";
      orch = "ns override";

      top = "btm";

      # systemd
      ctl = "systemctl";
      stl = "s systemctl";
      utl = "systemctl --user";
      ut = "systemctl --user start";
      un = "systemctl --user stop";
      up = "s systemctl start";
      dn = "s systemctl stop";
      jtl = "journalctl";
    };
  };

  fonts = {
    fontconfig.defaultFonts = {
      monospace = [ "DejaVu Sans Mono for Powerline" ];
      sansSerif = [ "DejaVu Sans" ];
    };
    packages = with pkgs; [
      powerline-fonts
      dejavu_fonts
      nerdfonts
    ];
  };

  programs.starship = {
    enable = true;
    settings = lib.importTOML ./_starship.toml;
  };

  #FIXME: Use home-manager for starship & direnv
  programs.bash = {
    interactiveShellInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
  };

  programs.fish = {
    interactiveShellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
      ${pkgs.direnv}/bin/direnv hook fish | source
    '';
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    openFirewall = lib.mkDefault false;
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
