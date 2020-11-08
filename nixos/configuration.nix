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
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  # get the rtl88 drivers for the trendnet usb adapter
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   rtl88x2bu
  #   rtl8814au
  # ];

  # Allow nonfree packages
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "dan-nixos-laptop";
    useDHCP = false;
    networkmanager = {
      enable = true;
    };
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
      "8.8.4.4"
      "2001:4860:4860::8888"
    ];
    interfaces = {
      wlp2s0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.111.117";
            prefixLength = 16;
          }
        ];
      };
    };
    firewall = {
      enable = false;
      # allowedUDPPorts = [
      #   41641
      #   61000
      #   32768
      # ];
      # allowedTCPPorts = [
      #   8008
      #   8009
      #   5900
      #   5901
      #   5902
      #   8080
      #   3000
      # ];
    };
  };
  # networking.hostName = "dan-nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.wlp2s0.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Use NetworkManager for networking
  # networking.networkmanager.enable = true;

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

  # set fish by default
  programs.fish.enable = true;

  # List services that you want to enable:

  # Tailscale is going to be included here
  services.tailscale.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;

    extraModules = [ pkgs.pulseaudio-modules-bt ];

    extraConfig = "
      load-module module-switch-on-connect
    ";

    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };

  # === X11 Settings ===
  services.xserver = {
    enable = true;
    layout = "us";

    # Set proprietary nvidia drivers
    videoDrivers = [ "modesetting" "nvidia" ];

    # Enable touchpad support.
    libinput.enable = true;

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

  # set the environment to nvidia offload
  environment.systemPackages = [
    nvidia-offload

    # we love tailscale
    pkgs.tailscale
    pkgs.kubernetes
    pkgs.kubectl
  ];

  # === BLUETOOTH SETTINGS ===
  hardware.bluetooth = {
    enable = true;
  };

  # ugh we need to start blueman here instead of home-manager for some reason
  # (TODO)
  # LOL we need to enable the blueman applet
  services.blueman.enable = true;

  # === DOCKER SETTINGS ===
  virtualisation.docker = {
    enable = true;
    # extraOptions = '' --network=host '';
  };

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

  # Enable picom
  services.picom = {
    enable          = true;
    fade            = false;
    shadow          = false;
  };

  # Enable kubernetes
  services.kubernetes = {
    addons.dns.enable = true;
    masterAddress = "localhost";
  };

  services.kubernetes.roles = [ "node" ];

  # this option is defined for user safety, this is NOT default nor will it be
  # any time soon. This is fine, just needs to be properly documented
  services.kubernetes.kubelet.extraOpts = "--fail-swap-on=false";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rjected = {
    isNormalUser = true;
    extraGroups = [ "docker" "audio" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
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

