{...}: {
  flake.nixosModules.podman = {pkgs, ...}: {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        defaultNetwork.settings = {
          # enables podman-compose
          dns_enabled = true;
        };
      };
    };
    environment.systemPackages = [pkgs.podman-compose];
    users.users.dotboris.extraGroups = ["podman"];
  };
}
