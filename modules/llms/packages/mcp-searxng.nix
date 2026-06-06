{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "1.1.1";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-Xbo4Fmu8OJBbm/hkxWfzyvVG0bVDVOw8Zriez9wACOg=";
      };
      npmDepsHash = "sha256-GhIIy9Q8/Fe5X5Xb/2dLmLLrkU3jopATwzT7ZkPtZg4=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
