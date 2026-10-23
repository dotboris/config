# This is for managing data files like CSV, TSV, etc.
{...}: {
  flake.homeModules.neovim = {
    lib,
    pkgs,
    ...
  }: {
    programs.nixvim = {
      plugins.csvview.enable = true;
      autoCmd = [
        {
          event = "FileType";
          pattern = ["csv" "tsv"];
          callback.__raw = ''
            function(ev)
              local csvview = require("csvview")
              if not csvview.is_enabled(ev.buf) then
                csvview.enable(ev.buf)
              end
            end
          '';
        }
      ];
    };
  };
}
