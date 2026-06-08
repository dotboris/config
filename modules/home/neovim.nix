{...}: {
  flake.homeModules.neovim = {...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      initLua = ''
        -- show line numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- indent with 2 spaces
        vim.opt.expandtab = true
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.autoindent = true
        vim.opt.smartindent = true

        -- search
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
        vim.opt.hlsearch = true
        vim.opt.incsearch = true

        -- display
        vim.opt.list = true -- show whitespace and the like
        vim.opt.listchars = {
          tab = "» ",
          trail = "·",
          space = "·",
          nbsp = "␣",
        }
        vim.opt.cursorline = true -- highlight line at cursor

        -- interaction
        vim.opt.clipboard = "unnamedplus"
        vim.opt.mouse = "a"
      '';
    };
  };
}
