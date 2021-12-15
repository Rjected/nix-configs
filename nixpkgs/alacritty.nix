{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    # neofetch for the args thing below!!
    neofetch
  ];

  # alacritty conf as nix
  programs.alacritty = {
    enable = true;

    # Main alacritty config
    settings = {
      background_opacity = 0.82;

      scrolling = {
        auto_scrolling = false;
        faux_multiplier = 0;
      };

      # Font settings
      font = {
        family = "NotoMono Nerd Font Mono";
        size = 10;
      };

      shell = {
        program = "fish";
      };

      # Color settings
      colors = {
        # Default colors
        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };

        # Normal colors
        normal = {
          black   = "0x131313";
          red     = "0x911c1c";
          green   = "0x4c3a3d";
          yellow  = "0x4e4e4e";
          blue    = "0x6f6f6f";
          magenta = "0x909090";
          cyan    = "0xaaa998";
          white   = "0xb1b1b1";
        };

        # Bright colors
        bright = {
          black   = "0xd1d1d1";
          red     = "0xd2c3ad";
          green   = "0xdf9767";
          yellow  = "0xe1e1e1";
          blue    = "0xededed";
          magenta = "0xed4b19";
          cyan    = "0xf2361e";
          white   = "0xfa390f";
        };
      };
    };
  };
}
