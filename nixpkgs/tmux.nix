{config, lib, pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set-window-option -g mode-keys vi
      set-option -g status on

      set-option -g history-limit 100000

      # visual notification of activity in other windows
      setw -g monitor-activity on
      set -g visual-activity on

      # Move between panes with vi keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R


      # Avoid ESC delay
      set -s escape-time 0

      # Fix titlebar
      set -g set-titles on
      set -g set-titles-string "#T"

      # show session name, window & pane number, date and time on right side of
      set -g status-right "%b %d %Y @ %l:%M %p"

      set -ga terminal-overrides ",alacritty:Tc"


      #### COLOUR (Solarized 256)

      # default statusbar colors
      set-option -g status-style fg=colour136,bg=colour235 #yellow and base02

      # default window title colors
      set-window-option -g window-status-style fg=colour244,bg=default #base0 and default
      #set-window-option -g window-status-style dim

      # active window title colors
      set-window-option -g window-status-current-style fg=colour166,bg=default #orange and default
      #set-window-option -g window-status-current-style bright

      # pane border
      set-option -g pane-border-style fg=colour235 #base02
      set-option -g pane-active-border-style fg=colour240 #base01

      # message text
      set-option -g message-style fg=colour166,bg=colour235 #orange and base02

      # pane number display
      set-option -g display-panes-active-colour colour33 #blue
      set-option -g display-panes-colour colour166 #orange

      # clock
      set-window-option -g clock-mode-colour colour64 #green

      # bell
      set-window-option -g window-status-bell-style fg=colour235,bg=colour160 #base02, red

      # now set the default shell to be fish
      set-option -g default-shell ~/.nix-profile/bin/fish
    '';

  };
}
