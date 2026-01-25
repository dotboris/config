{...}: {
  flake.homeModules.vscode = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.local.vscode;
  in {
    options.local.vscode = {
      enable = mkEnableOption "vscode";
      github-actions.enable = mkEnableOption "github-action support";
      go.enable = mkEnableOption "go support";
      iac.enable = mkEnableOption "IaC tools support";
      javascript.enable = mkEnableOption "javascript & typescript support";
      nix.enable = mkEnableOption "nix language support";
      python.enable = mkEnableOption "python support";
      rust.enable = mkEnableOption "rust support";
      shell.enable = mkEnableOption "shell language support";
      web.enable = mkEnableOption "web languages support";
    };

    config = mkIf cfg.enable {
      programs.vscode = let
        package = pkgs.vscodium;
      in {
        inherit package;
        enable = true;
        mutableExtensionsDir = true;
        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions = let
            exts = (pkgs.nix-vscode-extensions.forVSCodeVersion package.version).usingFixesFrom pkgs;
          in
            [
              exts.vscode-marketplace.ast-grep.ast-grep-vscode
              exts.vscode-marketplace.bierner.emojisense
              exts.vscode-marketplace.blueglassblock.better-json5
              exts.vscode-marketplace.editorconfig.editorconfig
              exts.vscode-marketplace.esbenp.prettier-vscode
              exts.vscode-marketplace.nefrob.vscode-just-syntax
              exts.vscode-marketplace.redhat.vscode-yaml
              exts.vscode-marketplace.sleistner.vscode-fileutils
              exts.vscode-marketplace.stkb.rewrap
              exts.vscode-marketplace.streetsidesoftware.code-spell-checker
              exts.vscode-marketplace.tamasfe.even-better-toml
              exts.vscode-marketplace.vscodevim.vim
            ]
            ++ lib.optionals cfg.github-actions.enable [
              exts.vscode-marketplace.github.vscode-github-actions
            ]
            ++ lib.optionals cfg.go.enable [
              exts.vscode-marketplace.golang.go
            ]
            ++ lib.optionals cfg.iac.enable [
              exts.vscode-marketplace.hashicorp.hcl
              exts.vscode-marketplace.hashicorp.terraform
              exts.vscode-marketplace.ms-kubernetes-tools.vscode-kubernetes-tools
            ]
            ++ lib.optionals cfg.javascript.enable [
              exts.vscode-marketplace.dbaeumer.vscode-eslint
              exts.vscode-marketplace.orta.vscode-jest
              exts.vscode-marketplace.yoavbls.pretty-ts-errors
            ]
            ++ lib.optionals cfg.nix.enable [
              exts.vscode-marketplace.jnoortheen.nix-ide
            ]
            ++ lib.optionals cfg.python.enable [
              exts.open-vsx.detachhead.basedpyright
              exts.vscode-marketplace.charliermarsh.ruff
              exts.vscode-marketplace.matangover.mypy
              exts.vscode-marketplace.ms-python.black-formatter
              exts.vscode-marketplace.ms-python.debugpy
              exts.vscode-marketplace.ms-python.python
            ]
            ++ lib.optionals cfg.rust.enable [
              exts.vscode-marketplace.rust-lang.rust-analyzer
              # disabled because build is broken
              # exts.vscode-marketplace.vadimcn.vscode-lldb
            ]
            ++ lib.optionals cfg.shell.enable [
              exts.vscode-marketplace.bmalehorn.vscode-fish
              exts.vscode-marketplace.timonwong.shellcheck
            ]
            ++ lib.optionals cfg.web.enable [
              exts.vscode-marketplace.astro-build.astro-vscode
              exts.vscode-marketplace.bradlc.vscode-tailwindcss
              exts.vscode-marketplace.unifiedjs.vscode-mdx
            ];
          userSettings =
            {
              # Customize window
              "workbench.startupEditor" = "newUntitledFile";
              "workbench.activityBar.location" = "hidden";
              "window.menuBarVisibility" = "compact";

              # Customize editor
              "editor.rulers" = [80];
              "editor.renderWhitespace" = "all";
              "editor.fontLigatures" = false;
              "editor.tabSize" = 2;
              "vim.useSystemClipboard" = true;
              "vim.handleKeys" = {
                "<C-p>" = false;
                "<C-j>" = false;
                "<C-b>" = false;
              };
              "files.insertFinalNewline" = true;
              "files.trimTrailingWhitespace" = true;

              # Disable bad features
              "redhat.telemetry.enabled" = false;
              "chat.commandCenter.enabled" = false;
              "telemetry.enableTelemetry" = false;
              "telemetry.enableCrashReporter" = false;
              "telemetry.feedback.enabled" = false;
              "telemetry.telemetryLevel" = "off";
              "update.enableWindowsBackgroundUpdates" = false;
              "update.mode" = "none";
              "update.showReleaseNotes" = false;
              "extensions.autoCheckUpdates" = false;
              "extensions.autoUpdate" = false;
              "workbench.enableExperiments" = false;
              "workbench.settings.enableNaturalLanguageSearch" = false;

              # We have to set this because the default is wrong
              "prettier.prettierPath" = "${pkgs.nodePackages.prettier}/lib/node_modules/prettier";

              # Language specific
              "[json]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[jsonc]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[json5]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
            }
            // lib.optionalAttrs cfg.go.enable {
              "go.inlayHints.assignVariableTypes" = true;
              "go.inlayHints.compositeLiteralFields" = true;
              "go.inlayHints.parameterNames" = true;
              "go.inlayHints.rangeVariableTypes" = true;
              "go.inlayHints.compositeLiteralTypes" = false;
            }
            // lib.optionalAttrs cfg.javascript.enable {
              # Enable all the inlay hints
              "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
              "javascript.inlayHints.parameterNames.enabled" = "all";
              "javascript.inlayHints.parameterTypes.enabled" = true;
              "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
              "javascript.inlayHints.variableTypes.enabled" = true;
              "typescript.inlayHints.enumMemberValues.enabled" = true;
              "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
              "typescript.inlayHints.parameterNames.enabled" = "all";
              "typescript.inlayHints.parameterTypes.enabled" = true;
              "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
              "typescript.inlayHints.variableTypes.enabled" = true;
              "[javascript]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[typescript]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[typescriptreact]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
            }
            // lib.optionalAttrs cfg.python.enable {
              "mypy.dmypyExecutable" = "${pkgs.mypy}/bin/dmypy";
              "[python]" = {
                "editor.tabSize" = 4;
                "editor.defaultFormatter" = "charliermarsh.ruff";
              };
            }
            // lib.optionalAttrs cfg.web.enable {
              "[astro]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[css]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "[mdx]" = {
                "editor.defaultFormatter" = "esbenp.prettier-vscode";
              };
              "tailwindCSS.includeLanguages" = {
                "astro" = "html";
              };
            };
          keybindings = [
            # emojisense tries to take over the ctrl+shift+i shortcuts
            {
              "key" = "ctrl+shift+i";
              "command" = "-emojisense.quickEmojitext";
              "when" = "editorTextFocus";
            }
            {
              "key" = "ctrl+shift+alt+i";
              "command" = "-emojisense.quickEmojitextTerminal";
              "when" = "terminalFocus";
            }
          ];
        };
      };
    };
  };
}
