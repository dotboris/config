{
  self,
  inputs,
  ...
}: {
  flake.profiles.foxtrot.nixos = {pkgs, ...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      self.nixosModules.gaming
      self.nixosModules.playwright
      self.nixosModules.users
      self.nixosModules.tailscale
      self.nixosModules.vms
      self.nixosModules.llms
    ];

    system.stateVersion = "25.05";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "foxtrot";
    networking.networkmanager.enable = true;
    networking.hosts = {
      "192.168.122.3" = [
        "homelab-test-foxtrot.lan"
        "home-test-foxtrot.dotboris.io"
        "archive-test-foxtrot.dotboris.io"
        "cloud-test-foxtrot.dotboris.io"
        "feeds-test-foxtrot.dotboris.io"
        "netdata-test-foxtrot.dotboris.io"
        "ntfy-test-foxtrot.dotboris.io"
        "traefik-test-foxtrot.dotboris.io"
        "search-test-foxtrot.dotboris.io"
      ];
    };
    services.resolved.enable = true;

    hardware.bluetooth.enable = true;

    time.timeZone = "America/Toronto";

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
    services.libinput.enable = true; # touchpad support

    services.ollama = {
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "11.0.2";
    };

    environment.systemPackages = [
      pkgs.neovim
      pkgs.btop
      pkgs.htop
      pkgs.busybox
      pkgs.dig
    ];

    services.fwupd.enable = true;

    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        cores = 0;
        max-jobs = "auto";
      };
      gc.automatic = true;
      optimise.automatic = true;
    };
  };
}
