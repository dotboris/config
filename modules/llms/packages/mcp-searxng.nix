{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "2.6.0";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-dbxJSSzwuJtwTSQN9JmGayISi4KKFly70rXk/U9/Fts=";
      };
      npmDepsHash = "sha256-+df6oLBlw8fE6baGs2G5Vmn2lQvyfLhg/2s9axuVNwo=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
