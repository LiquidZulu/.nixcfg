{
  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # hm
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    # Architecture
    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea.url = "github:nix-community/haumea";
    easy-hosts.url = "github:tgirlcloud/easy-hosts";

    # Developer Experience
    devshell.url = "github:numtide/devshell";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = { self, flake-parts, haumea, nixpkgs, easy-hosts, devshell
    , treefmt-nix, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({ ... }:
      let
        load = { src }:
          args@{ pkgs, ... }:
          let i = builtins.removeAttrs (args // { inherit inputs; }) [ "self" ];
          in if (nixpkgs.lib.pathIsDirectory src) then
            haumea.lib.load {
              inherit src;
              transformer = with haumea.lib.transformers; [
                liftDefault
                (hoistLists "_imports" "imports")
              ];
              loader = haumea.lib.loaders.scoped;
              inputs = i;
            }
          else
            haumea.lib.loaders.scoped i src;
        multiLoad = { dir }:
          nixpkgs.lib.mapAttrs' (name: _:
            nixpkgs.lib.nameValuePair (nixpkgs.lib.removeSuffix ".nix" name)
            (load { src = nixpkgs.lib.path.append dir name; }))
          (builtins.removeAttrs (builtins.readDir dir) [ "default.nix" ]);
      in {
        imports = [
          easy-hosts.flakeModule
          devshell.flakeModule
          treefmt-nix.flakeModule
        ];

        systems = [ "x86_64-linux" "aarch64-linux" ];

        perSystem = { pkgs, ... }: {
          treefmt = {
            programs.nixfmt.enable = true;
            flakeFormatter = true;
            projectRootFile = "flake.nix";
          };

          devshells.default = { commands = [{ package = pkgs.nix; }]; };
        };

        flake.profiles = {
          nixos = multiLoad { dir = ./nixosProfiles; };
          home = multiLoad { dir = ./homeProfiles; };
        };

        flake.suites = {
          nixos = let inherit (self.profiles) nixos;
          in {
            base =
              [ nixos.core nixos.nix nixos.cachix nixos.liquidzulu nixos.root ];
          };
          home = let inherit (self.profiles) home;
          in { base = [ home.direnv home.git ]; };
        };

        easy-hosts = let inherit (self) profiles suites;
        in {
          path = ./hosts;
          onlySystem = "x86_64-linux";

          shared = {
            specialArgs = { inherit inputs profiles suites; };
            modules = nixpkgs.lib.concatLists [ suites.nixos.base [ ] ];
          };

          hosts = {
            NixOS = { class = "nixos"; };
            laptop = { class = "nixos"; };
          };
        };
      });
}
