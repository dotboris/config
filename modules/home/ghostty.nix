{...}: {
  flake.homeModules.ghostty = {
    pkgs,
    config,
    ...
  }: let
    ghostty =
      if pkgs.stdenv.isLinux
      then (config.lib.nixGL.wrap pkgs.ghostty)
      else
        # `pkgs.ghostty-bin` works on mac but home-manager installs apps
        # incorrectly and Spotlight (cmd + space) can't find the installed app.
        # There's no easy fix for this so I'm just going to use brew for this.
        null;
  in {
    home.packages = [
      pkgs.fira-code
    ];

    programs.ghostty = {
      enable = true;
      package = ghostty;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = ghostty != null;
      installVimSyntax = ghostty != null;
      settings = {
        theme = "Dracula+";
        font-family = "Fira Code";
        # Turn off ligatures. They're annoying
        font-feature = [
          "-liga"
          "-calt"
          "-dlig"
        ];
        command = "${pkgs.fish}/bin/fish -l";
      };
    };
  };
}
