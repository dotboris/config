{pkgs, ...}: {
  programs.granted.enable = true; # Easily assume roles
  programs.awscli.enable = true;

  home.packages = [
    pkgs.ssm-session-manager-plugin
    pkgs.aws-vault # testing granted instead, TODO: remove this
  ];
}
