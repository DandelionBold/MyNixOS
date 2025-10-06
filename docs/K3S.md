# K3s Guide

K3s is disabled by default. Enable per host or via the `roles/k3s.nix` role.

## Enable K3s (server)

Add to the host (or import `roles/k3s.nix`):

```nix
services.k3s.enable = true;
services.k3s.role = "server";
```

Then rebuild the system. Verify with:

```bash
kubectl get nodes
```

## Enable K3s (agent)

On the agent host, set:

```nix
services.k3s.enable = true;
services.k3s.role = "agent";
# services.k3s.tokenFile = "/var/lib/rancher/k3s/server/node-token"; # adjust path
```

## Notes

- Secure your cluster: rotate tokens, restrict firewall ports to trusted networks.
- Use per-host firewall allow-lists (see `docs/FIREWALL.md`).
