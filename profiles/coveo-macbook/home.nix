{self, ...}: {
  flake.profiles.coveo-macbook.home = {...}: {
    imports = [
      self.homeModules.aws
      self.homeModules.base
      self.homeModules.neovim
      self.homeModules.ghostty
      self.homeModules.git
      self.homeModules.k8s
      self.homeModules.shell
      self.homeModules.vscode
    ];

    home.username = "bbera";
    home.homeDirectory = "/Users/bbera";

    local.git = {
      userName = "Boris Bera";
      userEmail = "bbera@coveo.com";
    };

    local.vscode = {
      enable = true;
      iac.enable = true;
      github-actions.enable = true;
      go.enable = true;
      javascript.enable = true;
      nix.enable = true;
      python.enable = true;
      shell.enable = true;
      web.enable = true;
    };
    programs.vscode.profiles.default.userSettings."editor.rulers" = [120];

    home.stateVersion = "25.05"; # Please read the comment before changing.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
