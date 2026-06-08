{inputs, ...}: {
  flake.homeModules.neovim = {...}: {
    imports = [inputs.nixvim.homeModules.nixvim];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      opts = {
        # Indentation
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        autoindent = true;
        smartindent = true;

        # Search
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
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

        # Behavior
        clipboard = "unnamedplus";
        mouse = "a";
      };
    };
  };
}
