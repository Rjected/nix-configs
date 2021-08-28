# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/21.11-pre";
    home-manager.url = "github:nix-community/home-manager/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, home-manager, nixpkgs, rust-overlay }: {
    nixosConfigurations.dan-nixos-sff = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/desktopConfiguration.nix
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rust-overlay.overlay ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rjected = import ./nixpkgs/home.nix;
        }
      ];
    };
    nixosConfigurations.dan-nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./nixos/laptopConfiguration.nix
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rust-overlay.overlay ];
        })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rjected = import ./nixpkgs/home.nix;
        }
      ];
    };
  };
}

