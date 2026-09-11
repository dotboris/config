{...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    nixpkgs.allowUnfreePackages = [
      "steam"
      "steam-unwrapped"
    ];

    programs.steam.enable = true;
    environment.systemPackages = [
      pkgs.lutris
    ];
  };

  flake.homeModules.gaming = {
    config,
    pkgs,
    ...
  }: {
    home.packages = let
      ps = [
        pkgs.prismlauncher # minecraft
      ];
    in
      builtins.map config.lib.nixGL.wrap ps;
  };
}
