# Setup shells the way I like them with the right utils in place and everything
{
  pkgs,
  lib,
  system,
  inputs,
  ...
}: {
  home.packages = [
    # Day to day utils
    inputs.cdo.packages.${system}.default

    pkgs.ripgrep
    pkgs.fd
    pkgs.sd
    pkgs.ast-grep
    pkgs.watchexec

    pkgs.jq
    pkgs.yq

    pkgs.jless

    # For fish.fzf plugin
    pkgs.fzf
  ];

  programs.bat.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_tree = true;
      proc_gradient = false;
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = null; # Seems to require nerdfonts which I don't want to require
  };

  # Only works on linux
  services.ssh-agent.enable = pkgs.stdenv.isLinux;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "2h";
      setEnv = {
        # Most servers don't have `xterm-ghostty` termcap
        TERM = "xterm-256color";
      };
    };
  };

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

      nix_shell.format = "via [$symbol]($style)";
      nodejs = {
        symbol = "[⬢](bold green) ";
        version_format = "v\${major}";
      };

      # Disable noisy stuff
      aws.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      buf.disabled = true;
      package.disabled = true;
      docker_context.disabled = true;
      rust.disabled = true;
    };
  };

  programs.fish = {
    enable = true;

    # PATH entries are added directly to the PATH var and to fish_user_paths to
    # ensure that nix shells can prepend stuff to the path correctly.
    interactiveShellInit = ''
      ${lib.strings.optionalString pkgs.stdenv.isDarwin ''
        fish_add_path --prepend --path /opt/homebrew/bin
      ''}
      fish_add_path --prepend --path ~/go/bin
      fish_add_path --prepend --path ~/.cargo/bin
      fish_add_path --prepend --path ~/.local/bin
      fish_add_path --prepend --path /nix/var/nix/profiles/default/bin
      fish_add_path --prepend --path ~/.nix-profile/bin
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
