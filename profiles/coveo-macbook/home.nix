{self, ...}: {
  flake.profiles.coveo-macbook.home = {pkgs, ...}: {
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

    home.packages = [
      # Playing around with LSPs
      pkgs.basedpyright
      pkgs.bash-language-server
      pkgs.gopls
      pkgs.jdt-language-server
      pkgs.terraform-ls
      pkgs.typescript-language-server
      pkgs.yaml-language-server
    ];

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

    # There's an automation that keeps editing / replacing this file.
    # It all ends up working out so it's probably fine.
    home.file.".ssh/config".force = true;

    home.stateVersion = "25.05"; # Only change this if a warning tells you to!

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
