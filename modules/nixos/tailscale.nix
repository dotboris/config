{withSystem, ...}: {
  flake.nixosModules.tailscale = {config, ...}: {
    services.tailscale = {
      enable = true;
      disableTaildrop = true;
      extraSetFlags = [
        "--operator=dotboris"
      ];
    };
    systemd.user.services.tailscale-systray = withSystem config.nixpkgs.system ({pkgs, ...}: {
      enable = true;
      description = "System tray widget to manage Tailscale";
      script = "${pkgs.tailscale}/bin/tailscale systray";
      after = ["network.target"];
      wantedBy = ["default.target"];
      unitConfig.ConditionUser = "dotboris";
    });
  };
}
