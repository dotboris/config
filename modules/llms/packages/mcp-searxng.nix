{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "2.1.0";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-Zq6oKXxmo+jaiSCGOsEB76y4xTEqU+WC1eQVFzsazXQ=";
      };
      npmDepsHash = "sha256-YIH/5RIdF/iSnUT+rWFUCKiwn3oPr1GJsgYvriJt0co=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
