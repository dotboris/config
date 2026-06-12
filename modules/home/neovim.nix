{inputs, ...}: {
  flake.homeModules.neovim = {...}: {
    imports = [inputs.nixvim.homeModules.nixvim];

    programs.nixvim = {
      enable = true;
      enableMan = false; # don't use it and it's noisy
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      diagnostic.settings = {
        virtual_text = {
          severity.min = "WARN";
          source = "if_many";
        };
        severity_sort = true;
      };
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
        {
          mode = "n";
          key = "<leader>xx";
          action = "<cmd>Trouble diagnostics toggle<cr>";
          options.desc = "Diagnostics (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>xX";
          action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
          options.desc = "Buffer Diagnostics (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>cs";
          action = "<cmd>Trouble symbols toggle focus=false<cr>";
          options.desc = "Symbols (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>cl";
          action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
          options.desc = "LSP Definitions / references / ... (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>xL";
          action = "<cmd>Trouble loclist toggle<cr>";
          options.desc = "Location List (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>xQ";
          action = "<cmd>Trouble qflist toggle<cr>";
          options.desc = "Quickfix List (Trouble)";
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
        gitsigns = {
          enable = true;
          settings = {
            current_line_blame = true;
            word_diff = true;
            # Mappings require lua because they're only set when plugin
            # attaches to a buffer
            on_attach = ''
              function (bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end, {desc='Go to next hunk'})

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end, {desc='Go to previous hunk'})

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, {desc = 'Stage hunk'})
                map('n', '<leader>hr', gitsigns.reset_hunk, {desc = 'Reset hunk'})

                map('v', '<leader>hs', function()
                  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, {desc = 'Stage hunk'})

                map('v', '<leader>hr', function()
                  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, {desc = 'Reset hunk'})

                map('n', '<leader>hS', gitsigns.stage_buffer, {desc = 'Stage whole buffer'})
                map('n', '<leader>hR', gitsigns.reset_buffer, {desc = 'Reset whole buffer'})
                map('n', '<leader>hp', gitsigns.preview_hunk, {desc = 'Preview hunk'})
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, {desc = 'Preview hunk (inline)'})

                map('n', '<leader>hb', function()
                  gitsigns.blame_line({ full = true })
                end, {desc = 'Blame line'})

                map('n', '<leader>hd', gitsigns.diffthis, {desc = 'Diff this'})

                map('n', '<leader>hD', function()
                  gitsigns.diffthis('~')
                end, {desc = 'Diff this (preivous commit)'})

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, {desc = 'Quickfix hunks (all)'})
                map('n', '<leader>hq', gitsigns.setqflist, {desc = 'Quickfix hunks (buffer)'})

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, {desc = 'Toggle line blame'})
                map('n', '<leader>tw', gitsigns.toggle_word_diff, {desc = 'Toggle word diff'})

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk, {desc = 'Select hunk'})
              end
            '';
          };
        };
        lspconfig.enable = true;
        mini-ai.enable = true;
        mini-comment.enable = true;
        mini-pairs.enable = true;
        mini-surround.enable = true;
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
              options.desc = "Search commands";
            };
            "<leader>F" = {
              action = "file_browser";
              options.desc = "File browser";
            };
            "<leader>fk" = {
              action = "keymaps";
              options.desc = "Find keymaps";
            };
            "<leader>fs" = {
              action = "lsp_document_symbols";
              options.desc = "Find symbols";
            };
            "<leader>fh" = {
              action = "help_tags";
              options.desc = "Find help tags";
            };
            "<leader>fd" = {
              action = "diagnostics";
              options.desc = "Find diagnostics";
            };
            "gd" = {
              action = "lsp_definitions";
              options.desc = "Go to definition";
            };
            "gD" = {
              action = "lsp_references";
              options.desc = "Go to references";
            };
            "gt" = {
              action = "lsp_type_definitions";
              options.desc = "Go to type definition";
            };
            "gi" = {
              action = "lsp_implementations";
              options.desc = "Go to implementations";
            };
            "gI" = {
              action = "lsp_incoming_calls";
              options.desc = "Go to incoming calls";
            };
            "gO" = {
              action = "lsp_outgoing_calls";
              options.desc = "Go to outgoing calls";
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
