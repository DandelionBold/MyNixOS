# Themes System

This directory contains theme configurations based on the [nixy themes repository](https://github.com/anotherhadi/nixy/tree/main/themes).

## Structure

```
themes/
├── themes.nix          # Main theme configuration
├── dark-theme.nix      # Dark theme variant
├── light-theme.nix     # Light theme variant
├── backgrounds/        # Local background images
│   └── backgrounds.nix # Background configuration
└── README.md          # This file
```

## Usage

### Basic Theme
Import the main theme configuration:
```nix
imports = [ ../features/system/themes/themes.nix ];
```

### Dark Theme
For a dark theme variant:
```nix
imports = [ ../features/system/themes/dark-theme.nix ];
```

### Light Theme
For a light theme variant:
```nix
imports = [ ../features/system/themes/light-theme.nix ];
```

### Background Images
To use local background images:
```nix
imports = [ ../features/system/themes/backgrounds/backgrounds.nix ];
```

## Background Images

Place your background images in the `backgrounds/` directory:
- `default.jpg` - Default desktop wallpaper
- `sddm.jpg` - SDDM login screen background
- `gnome.jpg` - GNOME wallpaper (if using GNOME)

## Customization

You can customize themes by:
1. Modifying the color schemes in theme files
2. Adding your own background images to the `backgrounds/` folder
3. Creating new theme variants by copying existing theme files

## Supported Desktop Environments

- **KDE Plasma**: Full theme support with breeze/breeze-dark
- **GNOME**: GTK theme support
- **Generic X11**: Basic theme support
- **SDDM**: Login screen theming

## References

- [nixy themes repository](https://github.com/anotherhadi/nixy/tree/main/themes)
- [NixOS theming documentation](https://nixos.wiki/wiki/GTK)
