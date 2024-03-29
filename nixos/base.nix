# This module defines a small base for NixOS configurations.
{ config, pkgs, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.loader.grub.device = "nodev";

  # Trying to get thunderbolt dock to work with this addition
  # boot.kernelPatches = [ {
  #   name = "thunderbolt";
  #   patch = null;
  #   extraConfig = ''
  #     THUNDERBOLT y
  #     HOTPLUG_PCI y
  #     HOTPLUG_PCI_ACPI y
  #   '';
  # } ];
  # nixpkgs.config.packageOverrides = pkgs: {
  #   linux = pkgs.linuxPackages.override {
  #     extraConfig = ''
  #       THUNDERBOLT m
  #       CONFIG_HOTPLUG_PCI y
  #       CONFIG_HOTPLUG_PCI_ACPI y
  #     '';
  #   };
  # };



  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = "1";
    "net.ipv6.conf.all.forwarding" = "1";
  };
  # Allow nonfree packages
  nixpkgs.config.allowUnfree = true;

  # set the environment to nvidia offload
  environment.systemPackages = [
    # we love tailscale
    pkgs.tailscale
    pkgs.fish
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_GB.UTF-8";
  };

  networking = {
    useDHCP = false;
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
      "8.8.4.4"
      "2001:4860:4860::8888"
    ];
    firewall = {
      # Disable the firewall altogether.
      enable = false;
      # allowedUDPPorts = [
      # ];
      # allowedTCPPorts = [
      # ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  # Enable acpid
  services.acpid.enable = true;

  # ok pulling out all the stops, let's install bolt
  services.hardware.bolt.enable = true;

  # Tailscale is going to be included here
  services.tailscale.enable = true;

  # TODO: REMOVE!!! - might have to do with tailscale or something else
  # nixpkgs.config.permittedInsecurePackages = [
  #   "go-1.14.15"
  # ];

  # set fish by default
  programs.fish.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = ''--dns 8.8.8.8 --dns 8.8.4.4'';
    };
  };

  # This allows us to handle access
  security = {
    polkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "rjected" ];
        commands = [
	  {
            command = "ALL";
	    options = [ "NOPASSWD" ];
	  }
	];
      }
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rjected = {
    isNormalUser = true;
    extraGroups = [ "input" "docker" "wheel" "kvm" "libvirtd" "plugdev" ];
    shell = pkgs.fish;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

