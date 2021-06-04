# This module defines a small base for NixOS configurations.
{config, pkgs, ...}:
{
  imports = [
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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

  # Tailscale is going to be included here
  services.tailscale.enable = true;

  # TODO: REMOVE!!! - might have to do with tailscale or something else
  nixpkgs.config.permittedInsecurePackages = [
    "go-1.14.15"
  ];

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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rjected = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "kvm" "libvirtd" "plugdev" ];
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

