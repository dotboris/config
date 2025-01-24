# Stuff that should be everywhere
{inputs, ...}: {
  programs.man.enable = true;
  news.display = "silent";
  fonts.fontconfig.enable = true;
  nixGL.packages = inputs.nixgl.packages;
  
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_tree = true;
      proc_gradient = false;
    };
  };
}
