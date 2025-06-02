{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cdo = {
      url = "github:dotboris/cdo";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixgl,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        packages = [
          # language server for nix
          pkgs.nil
          pkgs.alejandra

          # home-manager itself
          home-manager.packages.${system}.default
        ];
      };
    })
    // {
      homeConfigurations."desktop" = let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [./home-manager/hosts/desktop/home.nix];
          extraSpecialArgs = {
            inherit inputs system;
          };
        };

      homeConfigurations."coveo-macbook" = let
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [./home-manager/hosts/coveo-macbook/home.nix];
          extraSpecialArgs = {
            inherit inputs system;
          };
        };
    };
}
