{pkgs, ...}: {
  home.packages = [
    pkgs.tig
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        prc = "pr create -w";
        clone = "repo clone";
      };
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;

    userName = "Boris Bera";
    userEmail = "beraboris@gmail.com";

    extraConfig = {
      color.ui = "auto";
      push.default = "upstream";
      pull.rebase = false;
      init.defaultBranch = "main";
    };

    aliases = {
      poil = "pull";
      poule = "pull";
    };

    ignores = [
      ".vscode"
      ".alt.toml"
      "__scratch"

      # vim
      "[._]*.s[a-w][a-z]"
      "[._]s[a-w][a-z]"
      "*.un~"
      "Session.vim"
      ".netrwhist"
      "*~"
    ];
  };
}
