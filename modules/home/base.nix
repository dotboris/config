# Stuff that should be everywhere
{...}: {
  flake.homeModules.base = {...}: {
    programs.man.enable = true;
    news.display = "silent";
    fonts.fontconfig.enable = true;
  };
}
