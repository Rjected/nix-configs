{config, pkgs, ...}:
{
  services.xserver = {
    enable = true;
    layout = "us";

    # Set proprietary nvidia drivers
    videoDrivers = [ "nvidia" ];

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

  # Enable picom
  services.picom = {
    enable          = true;
    fade            = false;
    shadow          = false;
  };

  # Install noto sans
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Noto" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Set the dpi to 200
  fonts.fontconfig.dpi = 200;
}
