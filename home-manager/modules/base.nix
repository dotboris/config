# Stuff that should be everywhere
{...}: {
  programs.man.enable = true;
  news.display = "silent";
  
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_tree = true;
      proc_gradient = false;
    };
  };
}
