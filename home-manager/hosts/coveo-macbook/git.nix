{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    userName = lib.mkForce "Boris Bera";
    userEmail = lib.mkForce "bbera@coveo.com";

    extraConfig = {
      credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
    };

    ignores = [
      "__scratch/"
      ".alt.toml"

      # mac stuff
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon"
      "._*"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Vim stuff
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"
      "Session.vim"
      "Sessionx.vim"
      ".netrwhist"
      "*~"
      "tags"
      "[._]*.un~"

      # vscode
      ".vscode"
      "*.code-workspace"
      ".history/"
      ".history"
      ".ionide"
    ];
  };
}
