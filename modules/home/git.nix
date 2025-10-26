{...}: {
  flake.homeModules.git = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfg = config.local.git;
  in {
    options.local.git = {
      userName = lib.mkOption {type = lib.types.str;};
      userEmail = lib.mkOption {type = lib.types.str;};
    };

    config = {
      home.packages = [
        pkgs.tig
      ];

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings = {
          version = "1";
          git_protocol = "ssh";
          prompt = "enabled";
          aliases = {
            co = "pr checkout";
            prc = "pr create -w";
            clone = "repo clone";
          };
        };
      };

      programs.gpg.enable = true;
      services.gpg-agent = {
        # The `services.gpg-agent` doesn't support MacOS as of writing this. See:
        # - https://github.com/nix-community/home-manager/issues/3864
        # - https://github.com/nix-community/home-manager/pull/2964
        enable = pkgs.hostPlatform.isLinux;
        pinentry.package = pkgs.pinentry-tty;
      };

      # Fancy git diffs
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
      };

      programs.git = {
        enable = true;
        lfs.enable = true;

        signing = {
          key = null; # Let GPG pick
          signByDefault = true;
        };

        settings = {
          user.name = cfg.userName;
          user.email = cfg.userEmail;
          alias = {
            poil = "pull";
            poule = "pull";
          };
          color.ui = "auto";
          push.default = "upstream";
          pull.rebase = false;
          init.defaultBranch = "main";
        };

        ignores = [
          ".alt.toml"
          "__scratch"

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
    };
  };
}
