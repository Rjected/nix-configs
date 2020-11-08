{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  # we need rofi here because i3 depends on it
  home.packages = with pkgs; [
    # Rofi > dmenu
    rofi
  ];

  xsession.scriptPath = ".hm-xsession";

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      window = {
        border = 1;
        titlebar = false;
        hideEdgeBorders = "smart";
      };

      # Set the color for the border to be red
      colors = {
        focused = {
          border = "#4c7899";
          background = "#285577";
          text = "#ffffff";
          indicator = "#007f00";
          childBorder = "#004f00";
        };
      };

      fonts = [ "NotoMono Nerd Font Mono 10" ];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "exec --no-startup-id \"${pkgs.rofi}/bin/rofi -combi-modi 'window,drun,run,ssh' -show drun -sidebar-mode\"";
        "${mod}+o" = "exec --no-startup-id \"${pkgs.rofi}/bin/rofi -combi-modi 'window,drun,run,ssh' -show drun -sidebar-mode\"";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Focus mode toggle (also dmenu replacement)
        "${mod}+d" = "focus mode_toggle";

        # Make sure that tile vertical and horizontal still work
        "${mod}+backslash" = "split h; exec notify-send 'tile horizontally'";
        "${mod}+equal" = "split v; exec notify-send 'tile horizontally'";
        "${mod}+q" = "split toggle";

        # Use alacritty as terminal
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
