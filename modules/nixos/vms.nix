{...}: {
  flake.nixosModules.vms = {pkgs, ...}: {
    virtualisation.libvirtd.enable = true;
    users.users.dotboris.extraGroups = ["libvirtd"];
    environment.systemPackages = [
      pkgs.virt-manager
    ];
  };
}
