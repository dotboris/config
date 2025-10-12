{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cdo = {
      url = "github:dotboris/cdo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    home-manager,
    nix-vscode-extensions,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      debug = false;
      imports = [
        home-manager.flakeModules.home-manager
        ./modules/home/vscode
        ./modules/home/aws.nix
        ./modules/home/base.nix
        ./modules/home/desktop.nix
        ./modules/home/ghostty.nix
        ./modules/home/git.nix
        ./modules/home/k8s.nix
        ./modules/home/neovim.nix
        ./modules/home/shell.nix
        ./modules/nixos/gaming.nix
        ./modules/nixos/playwright.nix
        ./modules/nixos/users.nix
        ./modules/nixos/vms.nix
        ./profiles/coveo-macbook
        ./profiles/desktop
        ./profiles/foxtrot
      ];
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      perSystem = {
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [
            nix-vscode-extensions.overlays.default
          ];
          config.allowUnfree = true;
        };
        formatter = pkgs.writeShellApplication {
          name = "alejandra-format-repo";
          runtimeInputs = [pkgs.alejandra];
          text = "alejandra .";
        };
        devShells.default = pkgs.mkShell {
          packages = [
            # language server for nix
            pkgs.nil
            pkgs.alejandra

            # home-manager itself
            home-manager.packages.${system}.default
          ];
        };
      };
    });
}
