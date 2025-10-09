{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "foxtrot";
  networking.networkmanager.enable = true;

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

  users.users.dotboris = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  programs.steam.enable = true;
  environment.systemPackages = [
    pkgs.neovim
    pkgs.btop
    pkgs.htop
    pkgs.busybox
    pkgs.dig
    pkgs.lutris
  ];

  services.fwupd.enable = true;
  services.tailscale = {
    enable = true;
    disableTaildrop = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      cores = 0;
      max-jobs = "auto";
    };
    gc.automatic = true;
    optimize.automatic = true;
  };
}
