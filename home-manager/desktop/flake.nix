{
  description = "Home Manager configuration of dotboris";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cdo.url = "github:dotboris/cdo";
  };

  outputs = {
    nixpkgs,
    home-manager,
    cdo,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    getFlakePkg = {
      flake,
      packageName ? "default",
    }:
      flake.outputs.packages.${system}.${packageName};
  in {
    homeConfigurations."dotboris" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
        ../modules/base.nix
        ../modules/neovim.nix
        ../modules/git.nix
        ../modules/shell.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        cdo = getFlakePkg {flake = cdo;};
      };
    };

    formatter.${system} = pkgs.alejandra;
  };
}
