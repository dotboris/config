# Stuff that should be everywhere
{inputs, ...}: {
  programs.man.enable = true;
  news.display = "silent";
  fonts.fontconfig.enable = true;
  nixGL.packages = inputs.nixgl.packages;
}
