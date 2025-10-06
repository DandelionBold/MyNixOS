# MyNixOS: Troubleshooting Guide

Common issues and their solutions.

## Build Errors

### "file not found" Error
**Problem**: Configuration file cannot be found.

**Solution**:
1. Check the file path is correct
2. Ensure the file exists
3. Verify the file is in the right location

**Example**:
```bash
# Wrong
imports = [ ../features/nonexistent.nix ];

# Correct
imports = [ ../features/applications/browsers.nix ];
```

### "attribute not found" Error
**Problem**: Package or service name doesn't exist.

**Solution**:
1. Check the package name is correct
2. Search for the correct name: `nix search nixpkgs package-name`
3. Check if the package is available in your nixpkgs version

**Example**:
```bash
# Search for a package
nix search nixpkgs firefox

# Check if package exists
nix-env -qaP | grep firefox
```

### "permission denied" Error
**Problem**: Insufficient permissions to modify system.

**Solution**:
1. Run with sudo if needed
2. Check file permissions
3. Ensure you're in the right directory

**Example**:
```bash
# Run with sudo
sudo nixos-rebuild switch --flake .#laptop

# Check permissions
ls -la hosts/laptop/default.nix
```

### "flake not found" Error
**Problem**: Flake configuration cannot be found.

**Solution**:
1. Ensure you're in the project directory
2. Check that `flake.nix` exists
3. Verify the flake is properly formatted

**Example**:
```bash
# Check current directory
pwd

# List files
ls -la

# Check flake syntax
nix flake check
```

## Configuration Issues

### Service Won't Start
**Problem**: A service fails to start after configuration.

**Solution**:
1. Check service logs: `journalctl -u service-name`
2. Verify service configuration
3. Check dependencies are installed

**Example**:
```bash
# Check service status
systemctl status nginx

# View logs
journalctl -u nginx -f

# Restart service
sudo systemctl restart nginx
```

### Package Not Installed
**Problem**: Package is not available after configuration.

**Solution**:
1. Check if package is in the correct feature file
2. Verify the feature is imported
3. Rebuild the configuration

**Example**:
```bash
# Check if package is installed
which firefox

# Rebuild configuration
nixos-rebuild switch --flake .#laptop

# Check package in store
nix-store --query --references /run/current-system
```

### Theme Not Applied
**Problem**: Desktop theme doesn't change.

**Solution**:
1. Check if desktop environment is enabled
2. Verify theme files are imported
3. Restart desktop environment

**Example**:
```bash
# Check KDE is enabled
systemctl status sddm

# Restart desktop
sudo systemctl restart display-manager
```

## System Issues

### Boot Problems
**Problem**: System won't boot after configuration.

**Solution**:
1. Boot from previous generation
2. Check configuration syntax
3. Use emergency mode

**Example**:
```bash
# Boot from previous generation
nixos-rebuild switch --rollback

# Emergency mode
# Add "single" to kernel parameters in GRUB
```

### Network Issues
**Problem**: Network connection not working.

**Solution**:
1. Check NetworkManager status
2. Verify network configuration
3. Check hardware drivers

**Example**:
```bash
# Check NetworkManager
systemctl status NetworkManager

# Restart network
sudo systemctl restart NetworkManager

# Check network interfaces
ip addr show
```

### Audio Issues
**Problem**: Audio not working.

**Solution**:
1. Check PipeWire status
2. Verify audio configuration
3. Check hardware support

**Example**:
```bash
# Check PipeWire
systemctl --user status pipewire

# Restart audio
systemctl --user restart pipewire

# Check audio devices
pactl list short sinks
```

## Performance Issues

### Slow Boot
**Problem**: System takes too long to boot.

**Solution**:
1. Check for failed services
2. Optimize configuration
3. Use systemd-analyze

**Example**:
```bash
# Analyze boot time
systemd-analyze

# Check for slow services
systemd-analyze blame

# Check failed services
systemctl --failed
```

### High Memory Usage
**Problem**: System uses too much memory.

**Solution**:
1. Check running processes
2. Optimize services
3. Check for memory leaks

**Example**:
```bash
# Check memory usage
free -h

# Check top processes
top -o %MEM

# Check systemd services
systemctl list-units --state=running
```

## Development Issues

### Docker Not Working
**Problem**: Docker containers won't start.

**Solution**:
1. Check Docker service status
2. Verify user permissions
3. Check Docker configuration

**Example**:
```bash
# Check Docker status
systemctl status docker

# Add user to docker group
sudo usermod -aG docker $USER

# Restart Docker
sudo systemctl restart docker
```

### Git Not Working
**Problem**: Git commands fail.

**Solution**:
1. Check Git is installed
2. Verify configuration
3. Check permissions

**Example**:
```bash
# Check Git version
git --version

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Recovery Procedures

### Rollback to Previous Configuration
```bash
# List available generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous
nixos-rebuild switch --rollback

# Rollback to specific generation
nixos-rebuild switch --rollback 3
```

### Reset to Default Configuration
```bash
# Switch to default NixOS configuration
nixos-rebuild switch --flake nixpkgs#nixos

# Or use a minimal configuration
nixos-rebuild switch --flake nixpkgs#nixos --option system-profiles minimal
```

### Emergency Mode
1. Boot from GRUB menu
2. Select "NixOS - all configurations"
3. Choose previous working generation
4. Boot and fix configuration

## Getting Help

### Check Logs
```bash
# System logs
journalctl -f

# Service logs
journalctl -u service-name -f

# Boot logs
journalctl -b

# Kernel logs
dmesg
```

### Debug Configuration
```bash
# Test configuration without applying
nixos-rebuild build --flake .#laptop

# Show configuration trace
nixos-rebuild build --flake .#laptop --show-trace

# Check flake
nix flake check
```

### Online Resources
- [NixOS Manual](https://nixos.org/manual/nixos/)
- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Discourse](https://discourse.nixos.org/)
- [NixOS Reddit](https://www.reddit.com/r/NixOS/)

### Community Support
- Ask on NixOS Discourse
- Join NixOS IRC channel
- Check GitHub issues
- Search existing solutions

## Prevention

### Best Practices
1. **Test configurations** before applying
2. **Keep backups** of working configurations
3. **Use version control** for all changes
4. **Document changes** you make
5. **Start small** and build up

### Regular Maintenance
```bash
# Update system
nixos-rebuild switch --upgrade

# Clean old generations
nix-collect-garbage -d

# Update flake inputs
nix flake update
```

### Backup Strategy
1. Keep configuration in Git
2. Backup important data
3. Document custom changes
4. Test restore procedures

Remember: When in doubt, rollback to a working configuration and debug from there!
