# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.dan-nixos-sff = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/desktopConfiguration.nix ];
    };
    nixosConfigurations.dan-nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/laptopConfiguration.nix ];
    };
  };
}

