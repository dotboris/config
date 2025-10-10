{pkgs, ...}: {
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
  };
  qt = {
    enable = true;
    style = {
      name = "breeze";
      package = pkgs.kdePackages.breeze;
    };
  };
}
