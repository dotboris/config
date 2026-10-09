{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "2.5.1";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-TqDj86FTOekTswNQkTkiC8Q/H46bz4iigr5GRlM9Tno=";
      };
      npmDepsHash = "sha256-WuN8xzG5uU1wZdMLdiT2GfUn1BeHTdtIkBc4x2kz81Q=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
