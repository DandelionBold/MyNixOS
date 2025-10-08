{ config, lib, pkgs, ... }:

let
  cfg = config.secrets;
in
{
  options.secrets = {
    enable = lib.mkEnableOption "Install example secrets into predictable paths (for demos/tests).";

    files = lib.mkOption {
      type = with lib.types; attrsOf (submodule ({ name, ... }: {
        options = {
          source = lib.mkOption {
            type = path;
            description = "Path in the repo to the secret file (example or real).";
          };
          target = lib.mkOption {
            type = str;
            default = "/run/secrets/${name}";
            description = "Absolute path on the system where the secret will be exposed.";
          };
          owner = lib.mkOption {
            type = str;
            default = "root";
            description = "File owner (user).";
          };
          group = lib.mkOption {
            type = str;
            default = "root";
            description = "File group.";
          };
          mode = lib.mkOption {
            type = str;
            default = "0400";
            description = "File permissions in octal (as string).";
          };
        };
      }));
      default = {
        db_password = {
          # Example files live under ../../secrets/
          source = ../../secrets/db_password.example;
          target = "/run/secrets/db_password";
        };
        api_key = {
          source = ../../secrets/api_key.example;
          target = "/run/secrets/api_key";
        };
      };
      description = ''
        Map of named secrets. Each entry will be installed to the given target
        path using environment.etc with the requested owner, group and mode.
        For production, replace example files with a proper secret manager
        (e.g., sops-nix or agenix) and point `source` to the decrypted file.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc = lib.mapAttrs' (name: spec:
      lib.nameValuePair (lib.removePrefix "/etc/" spec.target) {
        source = spec.source;
        mode = spec.mode;
        user = spec.owner;
        group = spec.group;
      }
    ) cfg.files;
  };
}


