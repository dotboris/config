# Stuff that should be everywhere
{inputs, ...}: {
  flake.homeModules.base = {...}: {
    programs.man.enable = true;
    news.display = "silent";
    fonts.fontconfig.enable = true;
    nixGL.packages = inputs.nixgl.packages;
  };
}
