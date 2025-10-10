{...}: {
  flake.homeModules.neovim = {...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraConfig = ''
        set number
      '';
    };
  };
}
