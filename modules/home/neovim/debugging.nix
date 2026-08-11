{...}: {
  flake.homeModules.neovim = {
    lib,
    pkgs,
    ...
  }: {
    programs.nixvim = {
      keymaps = [
        {
          mode = "n";
          key = "<F5>";
          action.__raw = "function() require('dap').continue() end";
          options.desc = "Continue";
        }
        {
          mode = "n";
          key = "<F10>";
          action.__raw = "function() require('dap').step_over() end";
          options.desc = "Step over";
        }
        {
          mode = "n";
          key = "<F11>";
          action.__raw = ''
            function()
              require('dap').step_into()
            end
          '';
          options.desc = "Step into";
        }
        {
          mode = "n";
          key = "<F12>";
          action.__raw = ''
            function()
              require('dap').step_out()
            end
          '';
          options.desc = "Step out";
        }
        {
          mode = "n";
          key = "<leader>db";
          action.__raw = ''
            function()
              require('dap').toggle_breakpoint()
            end
          '';
          options.desc = "Toggle breakpoint";
        }
        {
          mode = "n";
          key = "<leader>dl";
          action.__raw = ''
            function()
              require('dap').set_breakpoint(
                nil,
                nil,
                vim.fn.input('Log point message: ')
              )
            end
          '';
          options.desc = "Set log point";
        }
        {
          mode = "n";
          key = "<leader>dl";
          action.__raw = ''
            function()
              require('dap').run_last()
            end
          '';
          options.desc = "Run last";
        }
        {
          mode = "n";
          key = "<leader>dq";
          action.__raw = ''
            function()
              require('dap').terminate()
            end
          '';
          options.desc = "Terminate debug session";
        }
        {
          mode = "n";
          key = "<leader>dv";
          action.__raw = ''
            function()
              require('dap-view').toggle()
            end
          '';
          options.desc = "Toggle debug view";
        }
      ];
      plugins = {
        dap = {
          enable = true;

          adapters.servers.pwa-node = {
            host = "localhost";
            port = 8123;
            executable = {
              command = lib.getExe pkgs.vscode-js-debug;
              args = ["8123"];
            };
          };
          configurations.javascript = [
            {
              type = "pwa-node";
              request = "launch";
              name = "Launch file";
              program = "\${file}";
              cwd = "\${workspaceFolder}";
              console = "integratedTerminal";
            }
          ];

          signs = {
            # color these thigns for I am blind
            dapBreakpoint.texthl = "ErrorMsg";
            dapBreakpointCondition.texthl = "ErrorMsg";
            dapBreakpointRejected.texthl = "WarningMsg";
            dapLogPoint.texthl = "ErrorMsg";
            dapStopped.texthl = "OkMsg";
          };
        };
        dap-python.enable = true;
        dap-go.enable = true;
        dap-view = {
          enable = true;
          settings.winbar = {
            controls.enabled = true;
            default_section = "scopes";
            sections = [
              "scopes"
              "watches"
              "console"
              "repl"
              "exceptions"
              "breakpoints"
              "threads"
            ];
            show_keymap_hints = false;
          };
        };
        dap-virtual-text.enable = true;
      };
    };
  };
}
