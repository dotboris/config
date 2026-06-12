{inputs, ...}: {
  flake.homeModules.neovim = {...}: {
    imports = [inputs.nixvim.homeModules.nixvim];

    programs.nixvim = {
      enable = true;
      enableMan = false; # don't use it and it's noisy
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      diagnostic.settings.virtual_text = true;
      globals.mapleader = " ";
      keymaps = [
        {
          mode = "n";
          key = "<leader>bc";
          action = "<cmd>bd<cr>";
          options.desc = "Close current buffer";
        }
        {
          mode = "n";
          key = "gf";
          action.__raw = "require('conform').format";
          options.desc = "Format document";
        }
      ];
      opts = {
        # Indentation
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        autoindent = true;
        smartindent = true;

        # Search
        ignorecase = true;
        smartcase = true;
        hlsearch = false;
        incsearch = true;

        # Display
        number = true;
        relativenumber = true;
        list = true;
        listchars = {
          tab = "» ";
          trail = "·";
          space = "·";
          nbsp = "␣";
        };
        cursorline = true;
        signcolumn = "yes";
        colorcolumn = [80];

        # Behavior
        clipboard = "unnamedplus";
        mouse = "a";
        scrolloff = 8;
      };
      colorschemes.catppuccin = {
        enable = true;
        settings.flavor = "mocha";
      };
      lsp = {
        inlayHints.enable = true;
        keymaps = [
          {
            key = "gd";
            lspBufAction = "definition";
            options.desc = "Go to definition";
          }
          {
            key = "gD";
            lspBufAction = "references";
            options.desc = "Go to references";
          }
          {
            key = "gt";
            lspBufAction = "type_definition";
            options.desc = "Go to type definition";
          }
          {
            key = "gi";
            lspBufAction = "implementation";
            options.desc = "Go to implementation";
          }
          {
            key = "K";
            lspBufAction = "hover";
            options.desc = "Hover";
          }
          {
            action = "<CMD>lsp restart<Enter>";
            key = "<leader>lr";
            options.desc = "Restart LSP servers";
          }
        ];
        servers = {
          astro.enable = true;
          basedpyright.enable = true; # python
          bashls.enable = true;
          codebook.enable = true; # spell checking
          cssls.enable = true;
          eslint.enable = true;
          fish_ls.enable = true;
          golangci_lint_ls.enable = true;
          gopls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          just.enable = true;
          nil_ls.enable = true; # nix
          nushell.enable = true;
          ruff.enable = true;
          rust_analyzer.enable = true;
          statix.enable = true; # nix linter
          tailwindcss.enable = true;
          ts_ls.enable = true;
          yamlls.enable = true;
        };
      };
      plugins = {
        # save & restore session like vscode
        auto-session.enable = true;
        # auto-complete
        blink-cmp = {
          enable = true;
          settings = {
            completion = {
              accept.auto_brackets.enabled = true;
              documentation.auto_show = true;
            };
            keymap.preset = "enter";
            signature.enabled = true;
          };
        };
        # formatting
        conform-nvim = {
          enable = true;
          autoInstall.enable = true; # Install formatters automatically
          settings = {
            default_format_opts = {
              async = true;
              lsp_format = "fallback";
            };
            formatters_by_ft = let
              jsFamily = ["eslint_d" "prettierd"];
            in {
              javacript = jsFamily;
              javacriptreact = jsFamily;
              json = ["prettierd"];
              nix = ["alejandra"];
              python = ["ruff_fix" "ruff_format"];
              typescript = jsFamily;
              typescriptreact = jsFamily;
            };
          };
        };
        gitsigns.enable = true;
        lspconfig.enable = true;
        # Fuzzy finder
        telescope = {
          enable = true;
          extensions = {
            file-browser = {
              enable = true;
              settings = {
                auto_depth = true;
                hijack_netrw = true;
                mappings = {
                  i."<C-x>" = "require('telescope._extensions.file_browser.actions').toggle_respect_gitignore";
                  n.x = "require('telescope._extensions.file_browser.actions').toggle_respect_gitignore";
                };
              };
            };
            frecency.enable = true;
            fzf-native.enable = true;
            ui-select.enable = true;
          };
          keymaps = {
            "<leader>," = {
              action = "buffers";
              options.desc = "Switch buffer";
            };
            "<leader>/" = {
              action = "live_grep";
              options.desc = "Grep project";
            };
            "<leader> " = {
              action = "find_files";
              options.desc = "Find files";
            };
            "<leader>:" = {
              action = "command_history";
              options.desc = "Command history";
            };
            "<leader>fc" = {
              action = "commands";
              options.desc = "search commands";
            };
            "<leader>F" = {
              action = "file_browser";
              options.desc = "file browser";
            };
            "<leader>fk" = {
              action = "keymaps";
              options.desc = "find keymaps";
            };
            "<leader>fs" = {
              action = "treesitter";
              options.desc = "find symbols";
            };
            "<leader>fh" = {
              action = "help_tags";
              options.desc = "find help tags";
            };
          };
          settings = {
            defaults = {
              file_ignore_patterns = [
                "^.git/"
              ];
              mappings = {
                n.q.__raw = "require('telescope.actions').close";
              };
            };
            pickers = {
              buffers = {
                initial_mode = "normal";
                sort_mru = true;
                sort_lastused = true;
                mappings = {
                  n.d.__raw = "require('telescope.actions').delete_buffer";
                  i."<C-d>".__raw = "require('telescope.actions').delete_buffer";
                };
              };
              find_files = {
                hidden = true;
              };
            };
          };
        };
        # Syntax highlighting & co
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
        };
        # Show context on top of file
        treesitter-context.enable = true;
        trouble.enable = true;
        which-key.enable = true;
      };
    };
  };
}
