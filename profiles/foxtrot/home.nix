{self, ...}: {
  flake.profiles.foxtrot.home = {...}: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.neovim
      self.homeModules.git
      self.homeModules.ghostty
      self.homeModules.k8s
      self.homeModules.shell
      self.homeModules.vscode
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
    xdg.enable = true;
    xdg.mime.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
