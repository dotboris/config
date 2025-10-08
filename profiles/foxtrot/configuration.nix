{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "foxtrot";
  networking.networkmanager.enable = true;

  # Set your time zone.
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
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dotboris = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
    packages = [
      pkgs.neovim
      pkgs.nextcloud-client
      pkgs.keepassxc
    ];
  };
  programs.fish.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = [
    pkgs.neovim
    pkgs.btop
    pkgs.htop
    pkgs.busybox
    pkgs.dig
  ];

  services.fwupd.enable = true;
  services.tailscale = {
    enable = true;
    disableTaildrop = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    cores = 0;
    max-jobs = "auto";
  };
}
