{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.fira-code
  ];

  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    enableBashIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "Dracula+";
      font-family = "Fira Code";
      font-size = 11;
      # Turn off ligatures. They're annoying
      font-feature = [
        "-liga"
        "-calt"
        "-dlig"
      ];
    };
  };
}
