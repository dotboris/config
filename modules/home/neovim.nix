{inputs, ...}: {
  flake.homeModules.neovim = {...}: {
    imports = [inputs.nixvim.homeModules.nixvim];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
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

        # Behavior
        clipboard = "unnamedplus";
        mouse = "a";
        scrolloff = 8;
      };
      plugins = {
        # Fuzzy finder
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options.desc = "find files";
            };
            # Like vscode
            "<C-p>" = {
              action = "git_files";
              options.desc = "find git files";
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
      };
    };
  };
}
