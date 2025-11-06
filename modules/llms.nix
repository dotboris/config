{...}: {
  flake.nixosModules.llms = {pkgs, ...}: {
    services.ollama.enable = true;

    environment.systemPackages = [
      pkgs.opencode
    ];
  };
}
