{...}: {
  flake.nixosModules.tailscale = {pkgs, ...}: {
    services.tailscale = {
      enable = true;
      disableTaildrop = true;
      extraSetFlags = [
        "--operator=dotboris"
      ];
    };
    systemd.user.services.tailscale-systray = {
      enable = true;
      description = "System tray widget to manage Tailscale";
      script = "${pkgs.tailscale}/bin/tailscale systray";
      after = ["network.target"];
      wantedBy = ["default.target"];
      unitConfig.ConditionUser = "dotboris";
    };
  };
}
