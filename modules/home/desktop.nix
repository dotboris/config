{...}: {
  flake.homeModules.desktop = {pkgs, ...}: {
    home.packages = [
      pkgs.chromium
      pkgs.firefox
      pkgs.keepassxc
      pkgs.libreoffice-qt-fresh
      pkgs.nextcloud-client
      pkgs.thunderbird
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
  };
}
