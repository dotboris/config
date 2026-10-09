{
  self,
  inputs,
  ...
}: {
  flake.profiles.desktop.home = {...}: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.neovim
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
    local.llms = {
      enable = true;
      enableOllama = true;
    };

    home.stateVersion = "26.05"; # Only change this if a warning tells you to!

    # Linux specific tweaks & integrations.
    targets.genericLinux = {
      # makes it work better on non-nixos hosts
      enable = true;
      nixGL = {
        packages = inputs.nixgl.packages;
        installScripts = ["mesa"];
      };
    };
    xdg.enable = true;
    xdg.mime.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
