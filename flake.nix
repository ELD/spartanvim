{
  description = "ELD's Neovim Configuration Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      inherit (flake-utils.lib) eachSystemMap;
      defaultSystems =
        [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
    in {
      packages = eachSystemMap defaultSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in {
          spartanvim-config = pkgs.callPackage ./pkgs/spartanvim-config.nix { };
          spartanvim =
            pkgs.callPackage ./pkgs/spartanvim.nix { inherit pkgs; };
        });

      apps = eachSystemMap defaultSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in {
          defaultApp = {
            type = "app";
            program = "${pkgs.spartanvim}/bin/nvim";
          };
        });

      devShells = eachSystemMap defaultSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in {
          default = pkgs.mkShell {
            packages = builtins.attrValues { inherit (pkgs) lemmy-help npins; };
          };
        });
      overlays = {
        packages = (final: prev: {
          spartanvim-config = self.packages.${prev.system}.spartanvim-config;
          spartanvim = self.packages.${prev.system}.spartanvim;
        });
      };
    };
}

