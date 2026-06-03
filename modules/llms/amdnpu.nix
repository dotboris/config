{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.llms = moduleWithSystem (
    {system, ...}: {
      lib,
      config,
      pkgs,
      ...
    }: let
      cfg = config.local.llms;
      pkgsFlm = import inputs.nixpkgs-fastflowlm {
        inherit system;
      };
      fastflowlm = pkgsFlm.fastflowlm;
    in {
      options.local.llms = {
        enableAmdNpu = lib.mkEnableOption "Local LLM acceleration with AMD NPU";
      };

      config = lib.mkIf cfg.enableAmdNpu {
        environment.systemPackages = [
          fastflowlm
        ];

        users = {
          groups = {
            npu = {};
            fastflowlm = {};
          };
          users = {
            dotboris.extraGroups = ["npu"];
            fastflowlm = {
              isSystemUser = true;
              group = "fastflowlm";
              extraGroups = ["npu"];
            };
          };
        };

        # SVA (Shared Virtual Addressing) requires IOMMU translated mode, not passthrough
        boot.kernelParams = ["iommu.passthrough=0"];

        # Add udev rules for NPU device access
        services.udev.extraRules = ''
          # AMD NPU (amdxdna) - allow users in npu group
          SUBSYSTEM=="accel", KERNEL=="accel[0-9]*", GROUP="npu", MODE="0660"
        '';

        # Increase locked memory limit for NPU buffer allocation
        # The NPU driver needs to mmap large buffers (64MB+)
        security.pam.loginLimits = [
          {
            domain = "@npu";
            type = "soft";
            item = "memlock";
            value = "unlimited";
          }
          {
            domain = "@npu";
            type = "hard";
            item = "memlock";
            value = "unlimited";
          }
        ];

        # Run fastflowlm as a service
        systemd.tmpfiles.rules = [
          "d /var/"
        ];
        systemd.services.fastflowlm = {
          enable = true;
          wantedBy = ["default.target"];
          description = "Run local LLMs on AMD NPU";
          serviceConfig = {
            User = "fastflowlm";
            Group = "fastflowlm";
            StateDirectory = "fastflowlm";
            LimitMEMLOCK = "infinity";
          };
          path = [fastflowlm];
          preStart = ''
            flm validate
          '';
          script = ''
            FLM_MODEL_PATH="$STATE_DIRECTORY" \
              flm serve -c ${builtins.toString (1024 * 64)} --quiet
          '';
        };
      };
    }
  );
}
