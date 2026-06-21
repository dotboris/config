{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Actual ref is the `fastflowlm` branch but 3 weeks ago that broke because
    # of a syntax error and hasn't been touched since. Pinning to a commit to
    # avoid breakage every update.
    nixpkgs-fastflowlm.url = "github:JohnMolotov/nixpkgs/f14aeddb7a0ab0b19cdcbced2ca840f0de578ca8";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
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

            pkgs.nix-update

            # home-manager itself
            home-manager.packages.${system}.default
          ];
        };
      };
    });
}
