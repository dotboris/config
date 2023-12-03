{
  description = "Home Manager configuration of bbera";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cdo.url = "github:dotboris/cdo/main";
  };

  outputs = {
    nixpkgs,
    home-manager,
    cdo,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    homeConfigurations."bbera" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ../../modules/base.nix
        ../../modules/neovim.nix
        ../../modules/git.nix
        ../../modules/shell.nix
        ../../modules/k8s.nix
        ./home.nix
        ./git.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        cdo = cdo.packages.${system}.default;
      };
    };
  };
}
