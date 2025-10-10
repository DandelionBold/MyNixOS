{ pkgs, home-manager, ... }:

let
  # Import the users list from nixos-settings
  usersData = import ../nixos-settings/usersList.nix { inherit pkgs; };
  users = usersData.users;
  
  # Helper to create Home Manager configuration for a user
  mkHomeConfig = username: user: {
    name = username;
    value = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { };
      modules = 
        # Import extra modules if defined
        (user.hm.extraModules or []) ++
        # Base configuration module
        [
          {
            home.username = username;
            home.homeDirectory = user.homeDirectory;
            home.stateVersion = "24.05";
            
            # Import user's HM configuration
            imports = user.hm.imports or [];
            
            # Theme configuration
            theme = user.hm.theme or { enable = false; };
            
            # Bash configuration (if defined)
            programs.bash = if (user.hm ? bash) then (user.hm.bash // {
              enable = user.hm.bash.enable or true;
            }) else {
              enable = false;
            };
            
            # Git configuration (if defined)
            programs.git = if (user.hm ? git) then (user.hm.git // {
              enable = user.hm.git.enable or true;
            }) else {
              enable = false;
            };
            
            # Vim configuration (if defined)
            programs.vim = if (user.hm ? vim) then (user.hm.vim // {
              enable = user.hm.vim.enable or false;
            }) else {
              enable = false;
            };
            
            # Zsh configuration (if defined)
            programs.zsh = if (user.hm ? zsh) then (user.hm.zsh // {
              enable = user.hm.zsh.enable or true;
            }) else {
              enable = false;
            };
          }
        ];
    };
  };
  
in
{
  # ============================================================================
  # Home Manager Generator - Dynamic Home Configurations
  # ============================================================================
  # This file generates Home Manager configurations for all users
  # defined in nixos-settings/usersList.nix
  #
  # Generated configurations can be activated with:
  #   home-manager switch --flake .#username
  #
  # Example:
  #   home-manager switch --flake .#casper
  #   home-manager switch --flake .#koko
  # ============================================================================

  # Generate homeConfigurations for all users
  homeConfigurations = builtins.mapAttrs mkHomeConfig users;
}
