{pkgs, ...}: {
  home.packages = [
    pkgs.chromium
    pkgs.firefox
    pkgs.keepassxc
    pkgs.libreoffice-qt-fresh
    pkgs.nextcloud-client
    pkgs.thunderbird
  ];
}
