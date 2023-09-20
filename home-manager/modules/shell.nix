# Setup shells the way I like them with the right utils in place and everything
{
  pkgs,
  cdo,
  ...
}: {
  home.packages = [
    # Day to day utils
    cdo
    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.sd
    pkgs.jq
    pkgs.yq
    pkgs.jless

    # For fish.fzf plugin
    pkgs.fzf
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      # Simple icons
      battery = {
        full_symbol = "• ";
        charging_symbol = "⇡ ";
        discharging_symbol = "⇣ ";
        unknown_symbol = "❓ ";
        empty_symbol = "❗ ";
      };
      erlang.symbol = "ⓔ ";
      pulumi.symbol = "🧊 ";

      nix_shell.format = "via [$symbol]($style) ";
      nodejs = {
        symbol = "[⬢](bold green) ";
        version_format = "v\${major}";
      };

      # Disable noisy stuff
      aws.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      buf.disabled = true;
      docker.disabled = true;
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      fish_add_path --prepend --move --path ~/.nix-profile/bin
    '';

    shellAbbrs = {
      dco = "docker-compose";
    };

    plugins = [
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "f9e2e48a54199fe7c6c846556a12003e75ab798e";
          sha256 = "sha256-CqRSkwNqI/vdxPKrShBykh+eHQq9QIiItD6jWdZ/DSM=";
        };
      }
    ];
  };

  programs.nushell = {
    enable = true;
  };
}
