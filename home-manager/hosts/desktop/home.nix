{pkgs, ...}: {
  imports = [
    ../../modules/base.nix
    ../../modules/browser.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/ghostty.nix
    ../../modules/k8s.nix
    ../../modules/shell.nix
  ];

  home.username = "dotboris";
  home.homeDirectory = "/home/dotboris";

  local.git = {
    userName = "Boris Bera";
    userEmail = "beraboris@gmail.com";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.nixd
    pkgs.nil
    pkgs.alejandra
  ];

  # Linux specific tweaks & integrations.
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
