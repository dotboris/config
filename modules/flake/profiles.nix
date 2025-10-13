{
  inputs,
  lib,
  config,
  withSystem,
  ...
}: let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  options.flake.profiles = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.system = lib.mkOption {
          type = lib.types.str;
        };
        options.nixos = lib.mkOption {
          type = lib.types.nullOr lib.types.deferredModule;
          default = null;
        };
        options.home = lib.mkOption {
          type = lib.types.nullOr lib.types.deferredModule;
          default = null;
        };
      }
    );
  };

  config.flake = {
    homeConfigurations = lib.pipe config.flake.profiles [
      (lib.filterAttrs (_: profile: profile.home != null))
      (lib.mapAttrs (
        name: profile: (withSystem profile.system ({pkgs, ...}:
          homeManagerConfiguration {
            inherit pkgs;
            modules = [profile.home];
          }))
      ))
    ];

    nixosConfigurations = lib.pipe config.flake.profiles [
      (lib.filterAttrs (_: profile: profile.nixos != null))
      (lib.mapAttrs (
        name: profile: (withSystem profile.system ({pkgs, ...}:
          nixosSystem {
            inherit pkgs;
            inherit (profile) system;
            modules = [profile.nixos];
          }))
      ))
    ];

    checks = lib.mkMerge (
      lib.mapAttrsToList (
        name: profile:
          lib.mkMerge [
            (lib.mkIf (profile.home != null) {
              ${profile.system} = {
                "profiles/${name}/home" =
                  config.flake.homeConfigurations.${name}.activation-script;
              };
            })
            (lib.mkIf (profile.nixos != null) {
              ${profile.system} = {
                "profiles/${name}/nixos" =
                  config.flake.nixosConfigurations.${name}.config.system.build.toplevel;
              };
            })
          ]
      )
      config.flake.profiles
    );
  };
}
