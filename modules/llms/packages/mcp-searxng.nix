{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "1.14.0";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-M3VfUAxocp+Trj68WofTXwMAxBcD2j5bzb2mmNEPnAE=";
      };
      npmDepsHash = "sha256-8R1DJ4S/q6ZLxPMVcBKTE0lJre5KAssWTreG4yNKZFw=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
