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
}
