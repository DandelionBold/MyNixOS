# Modules

System-wide building blocks: audio, bluetooth, filesystems, locale, networking, printing, nginx, k3s, databases, firewall rules, users.

- Purpose: small, focused NixOS modules exporting options.
- Style: clear option names, sensible defaults off unless safe to enable.
- Testing: each module should evaluate standalone in a minimal host.

Checklist (planned):
- filesystems (BTRFS+LUKS, subvolumes, compression, snapper skeleton)
- hibernate (swap + resume toggles)
- networking (NetworkManager)
- bluetooth (enable + codecs)
- printing/scanning (CUPS + SANE)
- audio (PipeWire + WirePlumber)
- nginx (base + vhost template)
- k3s (server/agent)
- databases (MySQL, MSSQL, Redis)
- firewall rules (allowed ports list per host)
- users (casper)
- locale/time/keyboard
