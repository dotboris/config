{...}: {
  perSystem = {pkgs, ...}: {
    packages.mcp-searxng = pkgs.buildNpmPackage (finalAttrs: {
      pname = "mcp-searxng";
      version = "1.11.1";
      src = pkgs.fetchFromGitHub {
        owner = "ihor-sokoliuk";
        repo = "mcp-searxng";
        tag = "v${finalAttrs.version}";
        hash = "sha256-R6pJ5fJ0V46rY7XZBhf7RDK5I3kVlqbbaxqtfm6XKkU=";
      };
      npmDepsHash = "sha256-3Mbhmd9Rw6k5OcbcfJf7JKXtgpke5GiDkf0CqY9YYAw=";
      meta.mainProgram = "mcp-searxng";
    });
  };
}
