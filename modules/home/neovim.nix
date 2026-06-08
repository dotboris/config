{...}: {
  flake.homeModules.neovim = {...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      initLua = ''
        -- show line numbers
        vim.wo.number = true
        vim.wo.relativenumber = true

        -- indent with 2 spaces
        vim.bo.expandtab = true
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.autoindent = true
        vim.bo.smartindent = true

        -- search
        vim.o.ignorecase = true
        vim.o.smartcase = true
        vim.o.hlsearch = true
        vim.o.incsearch = true

        -- display
        vim.o.list = true -- show whitespace and the like
        vim.opt.listchars = {
          tab = "» ",
          trail = "·",
          space = "·",
          nbsp = "␣",
        }
        vim.wo.cursorline = true -- highlight line at cursor

        -- interaction
        vim.opt.clipboard = "unnamedplus"
        vim.o.mouse = "a"
      '';
    };
  };
}
