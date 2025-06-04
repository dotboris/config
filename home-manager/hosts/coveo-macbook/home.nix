{...}: {
  imports = [
    ../../modules/aws.nix
    ../../modules/base.nix
    ../../modules/neovim.nix
    ../../modules/ghostty.nix
    ../../modules/git.nix
    ../../modules/k8s.nix
    ../../modules/shell.nix
    ../../modules/vscode
  ];

  home.username = "bbera";
  home.homeDirectory = "/Users/bbera";

  local.git = {
    userName = "Boris Bera";
    userEmail = "bbera@coveo.com";
  };

  local.vscode = {
    enable = true;
    javascript.enable = true;
    nix.enable = true;
    python.enable = true;
    shell.enable = true;
    web.enable = true;
  };
  programs.vscode.profiles.default.userSettings."editor.rulers" = [120];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
