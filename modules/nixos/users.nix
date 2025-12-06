{...}: {
  flake.nixosModules.users = {pkgs, ...}: {
    users.users.dotboris = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
  };
}
