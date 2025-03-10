{pkgs, ...}: {
  imports = [
    ../../modules/aws.nix
    ../../modules/base.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/k8s.nix
    ../../modules/shell.nix
  ];

  home.username = "bbera";
  home.homeDirectory = "/Users/bbera";

  local.git = {
    userName = "Boris Bera";
    userEmail = "bbera@coveo.com";
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
    pkgs.nil
    pkgs.alejandra

    pkgs.terraform

    pkgs.pre-commit
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
