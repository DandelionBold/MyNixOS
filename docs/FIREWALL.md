# Firewall Guide

Global policy: firewall disabled by default. Enable per host and declare allowed ports.

## How to enable on a host

- Edit the host `default.nix` and add:

```nix
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 80 443 ];
  allowedUDPPorts = [ ];
};
```

- Rebuild the system (`nixos-rebuild switch --flake .#<host>`).

## Verify open ports

- Run `ss -tulpen` or `sudo lsof -i -P -n` and confirm only the declared ports are listening.

## Common presets

- SSH only: `allowedTCPPorts = [ 22 ];`
- Web: `allowedTCPPorts = [ 80 443 ];`
- Redis (local/private nets only!): `allowedTCPPorts = [ 6379 ];`
- MySQL/MariaDB (private nets only!): `allowedTCPPorts = [ 3306 ];`

## Tips

- Prefer reverse proxies (nginx) and restrict DB ports to private networks.
- For dynamic rules beyond basic allow-lists, consider nftables directly.
