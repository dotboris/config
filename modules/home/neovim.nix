{ inputs, ... }: {
  flake.homeModules.neovim = { ... }: {
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      diagnostic.settings.virtual_text = true;
      globals.mapleader = " ";
      keymaps = [
        {
          key = "<C-/>";
          action = "gcc";
          mode = "n";
          options = {
            desc = "Toggle comment";
            remap = true;
          };
        }
        {
          key = "<C-/>";
          action = "gc";
          mode = "v";
          options = {
            desc = "Toggle comment";
            remap = true;
          };
        }
        {
          key = "<leader>bc";
          action = "<cmd>bd<cr>";
          mode = "n";
          options.desc = "Close current buffer";
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
        colorcolumn = [ 80 ];

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
            key = "gf";
            lspBufAction = "format";
            options.desc = "Format document";
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
        cmp = {
          enable = true;
          autoEnableSource = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping.confirm({ select = true })";
            };
          };
        };
        bufferline.enable = true;
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
                hidden = {
                  file_browser = true;
                  folder_browser = true;
                };
                mappings = {
                  i."<C-x>" = "require('telescope._extensions.file_browser.actions').toggle_respect_gitignore";
                  n.x = "require('telescope._extensions.file_browser.actions').toggle_respect_gitignore";
                };
              };
            };
            frequency.enable = true;
            fzf-native.enable = true;
            ui-select.enable = true;
          };
          keymaps = {
            "<leader>fc" = {
              action = "commands";
              options.desc = "search commands";
            };
            "<leader>ff" = {
              action = "file_browser";
              options.desc = "file browser";
            };
            "<leader>fk" = {
              action = "keymaps";
              options.desc = "find keymaps";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "live grep";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "find buffers";
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
