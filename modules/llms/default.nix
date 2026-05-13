{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.llms = moduleWithSystem (
    {system, ...}: {
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

        environment.systemPackages = [
          pkgs.opencode
        ];
      };
    }
  );
}
