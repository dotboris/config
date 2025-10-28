{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
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
    # nixpkgs doesn't have a working build for this yet so we use this flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    import-tree,
    home-manager,
    nix-vscode-extensions,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      debug = false;
      imports = [
        home-manager.flakeModules.home-manager
        (import-tree [
          ./modules
          ./profiles
        ])
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
