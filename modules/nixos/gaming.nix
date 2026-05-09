{...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    nixpkgs.allowUnfreePackages = [
      "steam"
      "steam-unwrapped"
    ];

    programs.steam.enable = true;
    environment.systemPackages = [
      # Lutris is currently failing to build because of ldap (WTF)
      # https://github.com/NixOS/nixpkgs/issues/513245
      # pkgs.lutris
    ];
  };
}
