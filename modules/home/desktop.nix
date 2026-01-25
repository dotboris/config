{moduleWithSystem, ...}: {
  flake.homeModules.desktop = moduleWithSystem ({inputs', ...}: {
    config,
    pkgs,
    ...
  }: {
    home.packages = [
      pkgs.chromium
      pkgs.firefox
      pkgs.keepassxc
      pkgs.libreoffice-qt-fresh
      pkgs.nextcloud-client
      pkgs.telegram-desktop
      pkgs.thunderbird
      (config.lib.nixGL.wrap inputs'.zen-browser.packages.default)

      # Spell Checking
      pkgs.hunspell
      pkgs.hunspellDicts.en-us-large
      pkgs.hunspellDicts.en-ca-large
      pkgs.hunspellDicts.fr-moderne
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Breeze";
        package = pkgs.kdePackages.breeze-gtk;
      };
      # Keeps getting replaced and giving me a warning every time I switch to a
      # new home-manager revision.
      gtk2.force = true;
    };
    qt = {
      enable = true;
      style = {
        name = "breeze";
        package = pkgs.kdePackages.breeze;
      };
    };
  });
}
