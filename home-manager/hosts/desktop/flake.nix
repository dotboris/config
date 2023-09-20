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
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    homeConfigurations."dotboris" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
        ../../modules/base.nix
        ../../modules/neovim.nix
        ../../modules/git.nix
        ../../modules/shell.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        cdo = cdo.packages.${system}.default;
      };
    };

    formatter.${system} = pkgs.alejandra;
  };
}
