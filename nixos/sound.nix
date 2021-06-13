{config, pkgs, ...}:
{
  environment.systemPackages = [
    pkgs.noisetorch
  ];

  # enable media keys via actkbd
  services.actkbd = {
    enable = true;
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  # Enable pulseaudio and bt module
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  users.users.rjected.extraGroups = [ "audio" ];
}
