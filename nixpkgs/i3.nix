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
      window.border = 0;

      fonts = [ "NotoMono Nerd Font Mono 10" ];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "exec ${pkgs.rofi}/bin/rofi";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
