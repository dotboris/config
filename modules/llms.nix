{...}: {
  flake.nixosModules.llms = {pkgs, ...}: {
    nixpkgs.allowUnfreePackages = ["open-webui"];

    services.ollama.enable = true;
    services.open-webui.enable = true;

    environment.systemPackages = [
      pkgs.opencode
    ];
  };
}
