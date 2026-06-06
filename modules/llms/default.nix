{...}: {
  flake.nixosModules.llms = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.local.llms;
  in {
    options.local.llms = {
      enable = lib.mkEnableOption "LLM tooling";
      enableOllama = lib.mkEnableOption "Local LLMs through Ollama";
    };

    config = lib.mkIf cfg.enable {
      nixpkgs.allowUnfreePackages = ["open-webui"];

      services.ollama.enable = cfg.enableOllama;
      services.open-webui.enable = true;
    };
  };

  flake.homeModules.llms = {
    config,
    lib,
    ...
  }: let
    cfg = config.local.llms;
  in {
    options.local.llms = {
      enable = lib.mkEnableOption "LLM tooling";
      enableOllama = lib.mkEnableOption "Ollama integration";
      enableFlm = lib.mkEnableOption "FastFlowLM integration";
    };

    config = lib.mkIf cfg.enable {
      programs.opencode = {
        enable = true;
        context = ''
          Respond terse like smart caveman. All technical substance stay. Only fluff die.

          Rules:
          - Drop: articles (a/an/the), filler (just/really/basically), pleasantries, hedging
          - Fragments OK. Short synonyms. Technical terms exact. Code unchanged.
          - Pattern: [thing] [action] [reason]. [next step].
          - Not: "Sure! I'd be happy to help you with that."
          - Yes: "Bug in auth middleware. Fix:"

          Auto-Clarity: drop caveman for security warnings, irreversible actions, user confused. Resume after.

          Boundaries: code/commits/PRs written normal.
        '';
        settings = {
          autoshare = false;
          autoupdate = false;
          share = "disabled";
          enabled_providers =
            []
            ++ lib.optionals cfg.enableOllama ["ollama"]
            ++ lib.optionals cfg.enableFlm ["fastflowlm"];
          permission = {
            edit = "ask";
            bash = {
              "*" = "ask";
              "grep *" = "allow";
              "git status*" = "allow";
              "git diff*" = "allow";
            };
            external_directory = "ask";
            websearch = "ask";
            webfetch = "ask";
          };
          provider = {
            ollama = lib.mkIf cfg.enableOllama {
              npm = "@ai-sdk/openai-compatible";
              name = "Ollama";
              options = {
                baseURL = "http://localhost:11434/v1";
              };
              models = {
                "gemma4:12b-code" = {
                  name = "Gemma4";
                };
              };
            };
            fastflowlm = lib.mkIf cfg.enableFlm {
              npm = "@ai-sdk/openai-compatible";
              name = "FastFlowLM";
              options = {
                baseURL = "http://localhost:52625/v1";
              };
              models = {
                "llama3.2:1b" = {
                  name = "LLama 3.2 1b";
                };
                "qwen3:8b" = {
                  name = "Qwen3 8b";
                };
                "gpt-oss:20b" = {
                  name = "GPT OSS";
                };
              };
            };
          };
        };
      };
    };
  };
}
