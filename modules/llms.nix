{...}: {
  flake.nixosModules.llms = {pkgs, ...}: {
    services.ollama.enable = true;
    services.open-webui.enable = true;

    environment.systemPackages = [
      pkgs.opencode
    ];
  };
}
