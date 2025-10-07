{ pkgs, home-manager, ... }:

let
  # Import the users list from nixos-settings
  usersData = import ../nixos-settings/usersList.nix { inherit pkgs; };
  usersList = usersData.usersList;
  
  # Helper to create Home Manager configuration for a user
  mkHomeConfig = user: {
    name = user.username;
    value = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        {
          home.username = user.username;
          home.homeDirectory = user.homeDirectory;
          home.stateVersion = "24.05";
          
          # Bash configuration
          programs.bash = user.bash // {
            enable = user.bash.enable or true;
          };
          
          # Git configuration
          programs.git = user.git // {
            enable = user.git.enable or true;
          };
          
          # Vim configuration
          programs.vim = user.vim // {
            enable = user.vim.enable or false;
          };
          
          # Zsh configuration (if defined)
          programs.zsh = if (user ? zsh) then (user.zsh // {
            enable = user.zsh.enable or true;
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

  # Generate homeConfigurations for all users in usersList
  homeConfigurations = builtins.listToAttrs (map mkHomeConfig usersList);
}
