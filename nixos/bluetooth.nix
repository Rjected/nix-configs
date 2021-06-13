{config, pkgs, ...}:
{
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    config = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;
  users.users.rjected.extraGroups = [ "audio" ];
}
