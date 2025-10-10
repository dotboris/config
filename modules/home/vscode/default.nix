{
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
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = true;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = let
          inherit
            (pkgs.nix-vscode-extensions)
            vscode-marketplace
            open-vsx
            ;
        in
          [
            vscode-marketplace.bierner.emojisense
            vscode-marketplace.blueglassblock.better-json5
            vscode-marketplace.editorconfig.editorconfig
            vscode-marketplace.esbenp.prettier-vscode
            vscode-marketplace.nefrob.vscode-just-syntax
            vscode-marketplace.redhat.vscode-yaml
            vscode-marketplace.sleistner.vscode-fileutils
            vscode-marketplace.stkb.rewrap
            vscode-marketplace.streetsidesoftware.code-spell-checker
            vscode-marketplace.tamasfe.even-better-toml
            vscode-marketplace.vscodevim.vim
          ]
          ++ lib.optionals cfg.github-actions.enable [
            vscode-marketplace.github.vscode-github-actions
          ]
          ++ lib.optionals cfg.go.enable [
            vscode-marketplace.golang.go
          ]
          ++ lib.optionals cfg.iac.enable [
            vscode-marketplace.hashicorp.hcl
            vscode-marketplace.hashicorp.terraform
            vscode-marketplace.ms-kubernetes-tools.vscode-kubernetes-tools
          ]
          ++ lib.optionals cfg.javascript.enable [
            vscode-marketplace.dbaeumer.vscode-eslint
            vscode-marketplace.yoavbls.pretty-ts-errors
          ]
          ++ lib.optionals cfg.nix.enable [
            vscode-marketplace.jnoortheen.nix-ide
          ]
          ++ lib.optionals cfg.python.enable [
            open-vsx.detachhead.basedpyright
            vscode-marketplace.charliermarsh.ruff
            vscode-marketplace.matangover.mypy
            vscode-marketplace.ms-python.black-formatter
            vscode-marketplace.ms-python.debugpy
            vscode-marketplace.ms-python.python
          ]
          ++ lib.optionals cfg.rust.enable [
            vscode-marketplace.rust-lang.rust-analyzer
            # Broken upstream. Not sure why
            # vscode-marketplace.vadimcn.vscode-lldb
          ]
          ++ lib.optionals cfg.shell.enable [
            vscode-marketplace.bmalehorn.vscode-fish
            vscode-marketplace.timonwong.shellcheck
          ]
          ++ lib.optionals cfg.web.enable [
            vscode-marketplace.astro-build.astro-vscode
            vscode-marketplace.bradlc.vscode-tailwindcss
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
            "extensions.autoCheckUpdates" = false;
            "extensions.autoUpdate" = false;
            "workbench.enableExperiments" = false;
            "workbench.settings.enableNaturalLanguageSearch" = false;

            # We have to set this because the default is wrong
            "prettier.prettierPath" = "${pkgs.nodePackages.prettier}";

            # Language specific
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
}
