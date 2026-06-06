{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "1.1.0";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-OVllsRMst6dWO/RagsmGyWN3muz1ATtffxfmLTfa0qU=";
      };
      npmDepsHash = "sha256-LN9yDbwvlICoFl5KgQvzZjLGXflVM0QkSzaB2dJzR/w=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
