{...}: {
  flake.homeModules.ghostty = {
    pkgs,
    config,
    ...
  }: let
    ghostty =
      if pkgs.stdenv.isLinux
      then (config.lib.nixGL.wrap pkgs.ghostty)
      else pkgs.ghostty-bin;
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
