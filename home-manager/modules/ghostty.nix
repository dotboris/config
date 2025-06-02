{
  lib,
  pkgs,
  config,
  ...
}: let
  # Package only works on linux. We only manage the config otherwise
  ghostty =
    if pkgs.stdenv.isLinux
    then (config.lib.nixGL.wrap pkgs.ghostty)
    else null;
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
}
