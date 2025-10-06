# Secrets

We will add secrets management later. Two options to consider:

- sops-nix: supports age or GPG, widely used.
- agenix: age-only, simple and clean.

Bootstrap (later):
- Generate age key; store securely.
- Create example encrypted secret and reference it from modules/HM.
