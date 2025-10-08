{...}: {
  imports = [
    ../../home-manager/modules/base.nix
    ../../home-manager/modules/neovim.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/ghostty.nix
    ../../home-manager/modules/k8s.nix
    ../../home-manager/modules/shell.nix
    ../../home-manager/modules/vscode
  ];

  home.username = "dotboris";
  home.homeDirectory = "/home/dotboris";

  local.git = {
    userName = "Boris Bera";
    userEmail = "beraboris@gmail.com";
  };
  local.vscode = {
    enable = true;
    github-actions.enable = true;
    go.enable = true;
    iac.enable = true;
    javascript.enable = true;
    nix.enable = true;
    python.enable = true;
    rust.enable = true;
    shell.enable = true;
    web.enable = true;
  };

  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Linux specific tweaks & integrations.
  targets.genericLinux.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
