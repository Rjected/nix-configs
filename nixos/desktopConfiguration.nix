{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/desktop.nix
      ./docker.nix
      ./virtualbox.nix
      ./base.nix
      ./graphical.nix
      ./sound.nix
      ./bluetooth.nix
      ./wifinated.nix
      ./ledger.nix
      ./vive.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev";
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  networking.hostName = "dan-nixos-sff"; # Define your hostname.

  environment.systemPackages = [
    pkgs.v4l-utils
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
