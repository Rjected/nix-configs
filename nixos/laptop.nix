# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



let
nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  exec -a "$0" "$@"
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/laptop.nix
      ./base.nix
      ./bluetooth.nix
      ./sound.nix
      ./graphical.nix
      ./wifinated.nix
      ./docker.nix
      ./ledger.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "nodev";
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  networking.hostName = "dan-nixos-laptop";

  # Set proprietary nvidia drivers
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # set the environment to nvidia offload
  environment.systemPackages = [
    nvidia-offload
  ];

  # === NVIDIA SETTINGS ===
  # Make sure that nvidia optimus is turned on
  hardware.nvidia = {
    prime = {
      offload.enable = true;

      # BUS ID of nvidia gpu. Found using lspci, under either 3D.
      nvidiaBusId = "PCI:1:0:0";

      # BUS ID of intel gpu. Found using lspci, under VGA.
      intelBusId = "PCI:0:2:0";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

