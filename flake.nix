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

    # NixOS configurations for all hosts
    nixosConfigurations = {
      laptop-casper = mkNixOSConfig "laptop-casper" "x86_64-linux";
      desktop-casper = mkNixOSConfig "desktop-casper" "x86_64-linux";
      server-01 = mkNixOSConfig "server-01" "x86_64-linux";
      vm-lab = mkNixOSConfig "vm-lab" "x86_64-linux";
      wsl = mkNixOSConfig "wsl" "x86_64-linux";
      cloud-01 = mkNixOSConfig "cloud-01" "x86_64-linux";
    };

    # Home Manager configurations (standalone)
    homeConfigurations = {
      "casper@laptop-casper" = hmLib.homeManagerConfiguration {
        pkgs = forSystem "x86_64-linux";
        modules = [ ./home/casper/default.nix ];
        # Optional: extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}


