# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl88x2bu
  ];

  # Allow nonfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-dan-sff"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Use NetworkManager for networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # === X11 Settings ===
  services.xserver = {
    enable = true;
    layout = "us";

    # Set proprietary nvidia drivers
    videoDrivers = [ "nvidia" ];

    # Enable touchpad support. (not needed for desktops, maybe should include only the laptop specific settings in an import and then fix the imports
    # whenever it's not a laptop
    # libinput.enable = true;

    desktopManager = {
      # disable basic xterm
      xterm.enable = false;
    };

    # Enable the none+i3 Desktop Environment.
    displayManager = {
      defaultSession = "none+i3";
    };

    # Enable i3 as a window manager
    windowManager.i3 = {
      enable = true;
    };

  };

  # === NVIDIA SETTINGS ===
  # haha we have none

  # Enable picom
  services.picom = {
    enable          = true;
    fade            = false;
    shadow          = false;
  };

  # Enable kubernetes
  # services.kubernetes = {
  #   apiserver.enable = true;
  #   controllerManager.enable = true;
  #   scheduler.enable = true;
  #   addonManager.enable = true;
  #   proxy.enable = true;
  #   flannel.enable = true;
  #   masterAddress = "localhost";
  # };

  # services.kubernetes.roles = [ "master" "node" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rjected = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # === FONTS ===
  # Make sure nerd fonts are imported
  nixpkgs.overlays = [ (import ./nix-nerd-fonts-overlay/default.nix) ];

  # Install noto sans
  fonts.fonts = with pkgs; [
    nerd-fonts.noto
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Set the dpi to 200 (same as in arch)
  fonts.fontconfig.dpi = 200;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

