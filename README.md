# nix-configs

Personal NixOS, Home Manager, and Neovim configuration.

The flake provides configurations for:

- `dan-nixos-sff`
- `dan-nixos-laptop`

Apply one from the repository root:

```sh
sudo nixos-rebuild switch --flake .#dan-nixos-sff
```

```sh
sudo nixos-rebuild switch --flake .#dan-nixos-laptop
```

`nixos/` contains system configuration, `nixpkgs/` contains Home Manager
modules and application configuration, and `nixpkgs/nvim/` contains the
Neovim configuration.
