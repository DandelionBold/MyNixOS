# Features

Features are composable, reusable configuration modules organized by functionality.

## Purpose
- Enable/disable groups of functionality as toggles per host
- Provide clean separation of concerns
- Make configurations DRY (Don't Repeat Yourself)
- Allow easy customization and extension

## Organization

Features are organized into logical categories:

### `applications/`
Individual application configurations:
- `browsers.nix` - Web browsers (Firefox, Brave)
- `terminals.nix` - Terminal emulators
- `file-managers.nix` - File management tools
- `gui-text-editors.nix` - GUI text editors
- `cli-text-editors.nix` - CLI text editors (Vim, Emacs)
- `screenshot-tools.nix` - Screenshot and recording tools
- `media-tools.nix` - Media editing and playback
- `office-suite.nix` - Office applications
- `system-tools.nix` - System utilities
- `other-applications.nix` - Miscellaneous apps

### `desktop-environments/`
Desktop environment configurations:
- `desktop-environment.nix` - Main DE importer
- `kde-plasma.nix` - KDE Plasma 6 with Wayland and SDDM

### `development/`
Development tool configurations:
- `dev.nix` - Main development feature importer
- `containers.nix` - Docker and Kubernetes (k3s)
- `databases.nix` - MySQL, MSSQL, Redis
- `programming-languages.nix` - Language toolchains (Python, etc.)
- `ides.nix` - IDEs and code editors (VSCode)
- `version-control.nix` - Git and related tools

### `hardware/`
Hardware-related configurations:
- `audio.nix` - PipeWire audio stack
- `bluetooth.nix` - Bluetooth support
- `printing.nix` - CUPS printing and SANE scanning

### `system/`
System-level configurations:
- `locale.nix` - Timezone, language, keyboard
- `networking.nix` - NetworkManager
- `filesystems-btrfs.nix` - BTRFS with compression
- `hibernate.nix` - Hibernation support
- `power.nix` - Power management
- `themes/` - [REMOVED] Themes moved to Home Manager per-user configuration

### Root Level
- `base.nix` - Base features imported by ALL hosts
- `gaming.nix` - Gaming support (Steam, Proton)

## Guidelines

1. **Features import modules**: Features should primarily import from `modules/`
2. **Avoid host-specific details**: Keep configurations generic and reusable
3. **Use lib.mkDefault**: Allow hosts to override settings
4. **Document options**: Add comments explaining what each feature does
5. **Organize logically**: Put features in appropriate subfolders

## Usage in Hosts

```nix
# hosts/laptop/default.nix
{
  imports = [
    ../features/base.nix                      # Always include
    ../features/desktop-environments/kde-plasma.nix
    ../features/applications/browsers.nix
    ../features/development/dev.nix
    # ... more features as needed
  ];
}
```

## Creating New Features

1. Create file in appropriate subfolder:
   ```bash
   touch features/applications/my-app.nix
   ```

2. Add configuration:
   ```nix
   { config, lib, pkgs, ... }:
   {
     environment.systemPackages = with pkgs; [
       my-application
     ];
     
     # Optional: configure the application
     programs.my-app = {
       enable = true;
     };
   }
   ```

3. Import in host configuration:
   ```nix
   imports = [
     ../features/applications/my-app.nix
   ];
   ```
