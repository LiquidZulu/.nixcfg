{
  description = "A highly structured configuration database.";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters =
      [ "https://nrdxp.cachix.org" "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {

    nix-doom-emacs = {
      # This is where you get it
      url = "github:nix-community/nix-doom-emacs";
      # We're overriding one of the inputs of their flake
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Track channels with commits tested and built by hydra
    nixos.url = "github:nixos/nixpkgs/nixos-23.05";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    # For darwin hosts: it can be helpful to track this darwin-specific stable
    # channel equivalent to the `nixos-*` channels for NixOS. For one, these
    # channels are more likely to provide cached binaries for darwin systems.
    # But, perhaps even more usefully, it provides a place for adding
    # darwin-specific overlays and packages which could otherwise cause build
    # failures on Linux systems.
    #nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.nixlib.follows = "nixos";
    digga.inputs.home-manager.follows = "home";
    digga.inputs.deploy.follows = "deploy";

    # remove this when flake-utils-plus is updated or merges the PR here: https://github.com/gytis-ivaskevicius/flake-utils-plus/compare/master...ravensiris:flake-utils-plus:ravensiris/fix-devshell-legacy-packages
    digga.inputs."flake-utils-plus".follows = "flake-utils-plus-fix";
    "flake-utils-plus-fix".url =
      "github:ravensiris/flake-utils-plus/7a8d789d4d13e45d20e6826d7b2a1757d52f2e13";

    home.url = "github:nix-community/home-manager/release-23.05";
    home.inputs.nixpkgs.follows = "nixos";

    #darwin.url = "github:LnL7/nix-darwin";
    #darwin.inputs.nixpkgs.follows = "nixpkgs-darwin-stable";

    deploy.url = "github:serokell/deploy-rs";
    deploy.inputs.nixpkgs.follows = "nixos";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixos";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixos";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    disko = {
      url = "nix-community/disko/v1.4.0";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { self, digga, nixos, home, nixos-hardware, nur, agenix, nvfetcher
    , deploy, nixpkgs, nix-doom-emacs, ... }@inputs:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = { allowUnfree = true; };

      channels = {
        nixos = {
          imports = [ (digga.lib.importOverlays ./overlays) ];
          overlays = [ ];
        };
        latest = { };
      };

      lib = import ./lib { lib = digga.lib // nixos.lib; };

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;
          lib = prev.lib.extend (lfinal: lprev: { our = self.lib; });
        })

        nur.overlay
        agenix.overlays.default
        nvfetcher.overlays.default

        (import ./pkgs)
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          imports = [ (digga.lib.importExportableModules ./modules) ];
          modules = [
            { lib.our = self.lib; }
            digga.nixosModules.nixConfig
            home.nixosModules.home-manager
            agenix.nixosModules.age
          ];
        };

        imports = [ (digga.lib.importHosts ./hosts) ];
        hosts = {
          # set host-specific properties here
          NixOS = { };
        };
        importables = rec {
          inherit inputs;
          diskoProfiles = digga.lib.rakeLeaves ./disko;
          profiles = digga.lib.rakeLeaves ./profiles // {
            users = digga.lib.rakeLeaves ./users;
          };
          suites = with profiles; rec {
            base = [ core.nixos users.liquidzulu users.root ];
          };
        };
      };

      home = {
        imports = [ (digga.lib.importExportableModules ./users/modules) ];
        modules = [ nix-doom-emacs.hmModule ];
        importables = rec {
          inherit inputs;
          profiles = digga.lib.rakeLeaves ./users/profiles;
          suites = with profiles; rec { base = [ direnv git ]; };
        };
        users = {
          # TODO: does this naming convention still make sense with darwin support?
          #
          # - it doesn't make sense to make a 'nixos' user available on
          #   darwin, and vice versa
          #
          # - the 'nixos' user might have special significance as the default
          #   user for fresh systems
          #
          # - perhaps a system-agnostic home-manager user is more appropriate?
          #   something like 'primaryuser'?
          #
          # all that said, these only exist within the `hmUsers` attrset, so
          # it could just be left to the developer to determine what's
          # appropriate. after all, configuring these hm users is one of the
          # first steps in customizing the template.
          liquidzulu = { suites, profiles, ... }: {
            imports = suites.base ++ (let inherit (profiles) doom; in [ doom ]);

            home.stateVersion = "22.11";
          };
        }; # digga.lib.importers.rakeLeaves ./users/hm;
      };

      devshell = ./shell;

      # TODO: similar to the above note: does it make sense to make all of
      # these users available on all systems?
      homeConfigurations =
        digga.lib.mkHomeConfigurations self.nixosConfigurations;
      #        digga.lib.mergeAny
      #        (digga.lib.mkHomeConfigurations self.nixosConfigurations);

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };
    };
}
