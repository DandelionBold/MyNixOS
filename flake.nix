{
  description = "MyNixOS: Professional, multi-host NixOS config with flakes + Home Manager (standalone)";

  # Flake-level Nix configuration
  nixConfig = {
    # Prefer well-known binary caches for faster builds
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    # Primary channel: nixpkgs unstable per roadmap
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager as flake input (standalone usage, but providing modules as well)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional hardware db for specific devices (left for later enablement)
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = inputs: let
    inherit (inputs) nixpkgs home-manager; # nixos-hardware (optional)
    
    # Supported systems
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    
    # Default system for hosts
    defaultSystem = "x86_64-linux";
    
    # Helper to make pkgs for a given system
    forSystem = system: import nixpkgs {
      inherit system;
      config = {
        # Global policy per roadmap; allow overrides per host if needed
        allowUnfree = true;
      };
    };
    
    # Helper to create NixOS configurations
    mkNixOSConfig = hostName: system: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./hosts/${hostName}/default.nix ];
    };
    
    hmLib = home-manager.lib;
  in {
    # Development shells for all supported systems
    devShells = forAllSystems (system: {
      default = (forSystem system).mkShell {
        packages = with (forSystem system); [
          # Add common CLI tools here (e.g., git, nixfmt, alejandra)
        ];
      };
    });

    # Host tree structure - defines which hosts have variants and their names
    hostTree = {
      laptop = [ "personal" ];
      desktop = [ ];
      server = [ ];
      vm = [ "personal" ];
      wsl = [ ];
      cloud = [ ];
    };
    
    # Helper to check if variant config exists for a host
    hasVariantConfig = hostName: variantName: 
      builtins.pathExists ./hosts/${hostName}/${variantName}/${variantName}.nix;
    
    # Helper to create all configurations dynamically
    mkAllConfigs = builtins.foldl' (acc: hostName: 
      let
        hostConfig = hostTree.${hostName} or [];
        baseConfig = { ${hostName} = mkNixOSConfig hostName defaultSystem; };
        variantConfigs = builtins.foldl' (variantAcc: variantName:
          if hasVariantConfig hostName variantName then
            variantAcc // { "${hostName}@${variantName}" = mkNixOSConfig "${hostName}/${variantName}" defaultSystem; }
          else
            variantAcc
        ) {} hostConfig;
      in
        acc // baseConfig // variantConfigs
    ) {} (builtins.attrNames hostTree);

    # NixOS configurations for all hosts (dynamically generated)
    nixosConfigurations = mkAllConfigs;

    # Home Manager configurations (standalone)
    homeConfigurations = {
      "casper" = hmLib.homeManagerConfiguration {
        pkgs = forSystem defaultSystem;
        modules = [ ./home/casper/default.nix ];
        # Optional: extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}


