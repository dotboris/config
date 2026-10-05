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
    ];

    home.username = "bbera";
    home.homeDirectory = "/Users/bbera";

    home.packages = [];

    local.git = {
      userName = "Boris Bera";
      userEmail = "bbera@coveo.com";
    };
    programs.git.ignores = [
      ".claude/settings.local.json"
      ".claude/worktrees/"
    ];

    # There's an automation that keeps editing / replacing this file.
    # It all ends up working out so it's probably fine.
    home.file.".ssh/config".force = true;

    home.stateVersion = "25.05"; # Only change this if a warning tells you to!

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
