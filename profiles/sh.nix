{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fish ];

  programs = {

    fish = { enable = true; };

    # Starship Prompt, see: https://nix-community.github.io/home-manager/options.html#opt-programs.starship.settings
    starship = {
      enable = true;
      settings = {

        character = {
          success_symbol = "[❯](bold purple)";
          vicmd_symbol = "[❮](bold purple)";
        };

        directory = {
          style = "cyan";
          read_only = " ";
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          symbol = " ";
          style = "bold dimmed white";
        };

        git_status = {
          format = "([「$all_status$ahead_behind」]($style) )";
          conflicted = "⚠️";
          ahead = "⟫\${count} ";
          behind = "⟪\${count} ";
          diverged = "🔀 ";
          untracked = "📁 ";
          stashed = "↪ ";
          modified = "𝚫 ";
          staged = "✔ ";
          renamed = "⇆ ";
          deleted = "✘ ";
          style = "bold bright-white";
        };

        # Nerd Fonts
        aws = { symbol = "  "; };
        buf = { symbol = " "; };
        c = { symbol = " "; };
        conda = { symbol = " "; };
        dart = { symbol = " "; };
        docker_context = { symbol = " "; };
        elixir = { symbol = " "; };
        elm = { symbol = " "; };
        golang = { symbol = " "; };
        guix_shell = { symbol = " "; };
        haskell = { symbol = " "; };
        haxe = { symbol = "⌘ "; };
        hg_branch = { symbol = " "; };
        java = { symbol = " "; };
        julia = { symbol = " "; };
        lua = { symbol = " "; };
        meson = { symbol = "喝 "; };
        nim = { symbol = " "; };
        nodejs = { symbol = " "; };

        os.symbols = {
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "﯑ ";
          Gentoo = " ";
          HardenedBSD = "ﲊ ";
          Illumos = " ";
          Linux = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = " ";
          openSUSE = " ";
          OracleLinux = " ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = " ";
          Solus = "ﴱ ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = " ";
        };

        package = { symbol = " "; };
        python = { symbol = " "; };
        rlang = { symbol = "ﳒ "; };
        ruby = { symbol = " "; };
        rust = { symbol = " "; };
        scala = { symbol = " "; };
        spack = { symbol = "🅢 "; };
        memory_usage = {
          symbol = " ";
          disabled = false;
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = " ";
          pure_msg = "λ";
          impure_msg = "⎔";
        };

        status = { disabled = false; };
      };
    };
  };
}
