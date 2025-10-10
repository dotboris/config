{pkgs, ...}: {
  home.packages = [
    pkgs.kubectl
    pkgs.kind
  ];

  programs.k9s.enable = true;
}
