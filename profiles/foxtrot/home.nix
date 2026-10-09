{self, ...}: {
  flake.profiles.foxtrot.home = {...}: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.neovim
      self.homeModules.gaming
      self.homeModules.git
      self.homeModules.ghostty
      self.homeModules.llms
      self.homeModules.k8s
      self.homeModules.shell
    ];

    home.username = "dotboris";
    home.homeDirectory = "/home/dotboris";

    local.git = {
      userName = "Boris Bera";
      userEmail = "boris@dotboris.io";
    };

    home.stateVersion = "26.05"; # Only change this if a warning tells you to!

    # Linux specific tweaks & integrations.
    xdg.enable = true;
    xdg.mime.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
