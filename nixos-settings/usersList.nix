{ pkgs, ... }:

{
  # ============================================================================
  # Users List - Single Source of Truth for All Users
  # ============================================================================
  # This file defines ALL users that can be created on ANY host.
  # Each host will select which users to enable from this list.
  # 
  # Structure:
  # - System configuration (NixOS users.users.*)
  # - Home Manager configuration (per-user dotfiles and settings)
  #
  # Usage:
  # In your host config, specify: selectedUsers = [ "casper" "koko" ];
  # ============================================================================

  users = {
    # -------------------------------------------------------------------------
    # User: casper
    # -------------------------------------------------------------------------
    casper = {
      # === NixOS System User Configuration ===
      username = "casper";
      isNormalUser = true;
      description = "Casper - Main User";
      extraGroups = [ 
        "wheel"           # sudo access
        "networkmanager"  # network management
        "docker"          # docker access
        "video"           # video devices
        "audio"           # audio devices
      ];
      shell = pkgs.bashInteractive;
      homeDirectory = "/home/casper";
      
      # === Home Manager Configuration ===
      hm = {
        extraModules = [ ../modules/theme.nix ];
        
        # Bash configuration
        bash = {
          enable = true;
          enableCompletion = true;
          shellAliases = {
            # Navigation
            ll = "ls -la";
            la = "ls -A";
            l = "ls -CF";
            ".." = "cd ..";
            "..." = "cd ../..";
            
            # Git shortcuts
            gs = "git status";
            ga = "git add";
            gc = "git commit";
            gp = "git push";
            gl = "git log --oneline";
            gd = "git diff";
            
            # NixOS shortcuts
            rebuild = "sudo nixos-rebuild switch --flake .";
            update = "nix flake update";
            clean = "nix-collect-garbage -d";
          };
          
          # Bash prompt customization
          bashrcExtra = ''
            # Custom prompt with git branch
            parse_git_branch() {
              git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
            }
            PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
          '';
        };
        
        # Git configuration
        git = {
          enable = true;
          userName = "Casper";
          userEmail = "casper@example.com";
          extraConfig = {
            init.defaultBranch = "main";
            core.editor = "vim";
            pull.rebase = false;
            push.autoSetupRemote = true;
          };
        };
        
        # Vim configuration
        vim = {
          enable = true;
          defaultEditor = true;
          settings = {
            number = true;
            relativenumber = true;
            expandtab = true;
            tabstop = 2;
            shiftwidth = 2;
          };
        };
        
        # Theme configuration
        theme = {
          enable       = true;
          gtkThemeName = "adw-gtk3";
          iconName     = "Papirus";
          cursorName   = "Bibata-Modern-Classic";
          cursorSize   = 24;
        };
      };
    };
    
    # -------------------------------------------------------------------------
    # User: koko (Example second user)
    # -------------------------------------------------------------------------
    koko = {
      # === NixOS System User Configuration ===
      username = "koko";
      isNormalUser = true;
      description = "Koko - Secondary User";
      extraGroups = [ 
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
      homeDirectory = "/home/koko";
      
      # === Home Manager Configuration ===
      hm = {
        extraModules = [ ../modules/theme.nix ];
        
        # Bash configuration (fallback)
        bash = {
          enable = true;
          enableCompletion = true;
          shellAliases = {
            ll = "ls -la";
            gs = "git status";
            rebuild = "sudo nixos-rebuild switch --flake .";
          };
        };
        
        # Zsh configuration
        zsh = {
          enable = true;
          enableCompletion = true;
          ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [ "git" "docker" "sudo" ];
          };
          shellAliases = {
            ll = "ls -la";
            gs = "git status";
            rebuild = "sudo nixos-rebuild switch --flake .";
          };
        };
        
        # Git configuration
        git = {
          enable = true;
          userName = "Koko";
          userEmail = "koko@example.com";
          extraConfig = {
            init.defaultBranch = "main";
            core.editor = "nano";
            pull.rebase = false;
          };
        };
        
        # Vim configuration
        vim = {
          enable = true;
          settings = {
            number = true;
            expandtab = true;
            tabstop = 4;
          };
        };
        
        # Theme configuration (light theme for koko)
        theme = {
          enable       = true;
          gtkThemeName = "adw-gtk3";
          iconName     = "Papirus";
          cursorName   = "Bibata-Modern-Classic";
          cursorSize   = 20;
        };
      };
    };
    
    # -------------------------------------------------------------------------
    # Add more users here following the same pattern
    # -------------------------------------------------------------------------
  };
}
