# nix-configs

These are my nix configs for trying out NixOS.
I'm using NixOS so that I can easily manage my operating system configuration, which is more and more
difficult as I get new computers and use more of them. I often keep coming back to my laptop
configuration, which I have put too much work into configuring, and I'm sure many of the steps in that
process have been lost.
So far, NixOS and Nix have solved all of my problems with configuring the linux desktop.
I'm backing up my configuration on GitHub and documenting for myself how to replicate this
configuration across my devices.

## How to set up on a new device
First, make sure wifi is set up, and the basic first user is set up.
This could all be done in a TTY.
Now, make sure to move to unstable channels and add home-manager
```sh
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
```

Make sure git is not globally installed, so use `nix-env --uninstall git` if you need to.
Next, run a new `nix-shell -p git` and clone this repo into `~/Projects/`.
Navigate to `~/Projects/nix-configs/nixos/` and build the flake for the device desired:
```sh
sudo nixos-rebuild switch --flake '.#desired-device-here'
```
Currently, the devices available are `dan-nixos-sff` and `dan-nixos-laptop`.
Then, run `sudo nixos-rebuild switch` and `home-manager switch`.

### i3 Config options
Just because this info is kind of annoying to find, [here are all the options for i3](https://github.com/rycee/home-manager/blob/master/modules/services/window-managers/i3-sway/lib/options.nix), and
[here are all the default config options](https://github.com/rycee/home-manager/blob/master/modules/services/window-managers/i3-sway/i3.nix).

### Cheat sheet
In order to update packages for the OS (not managed by home-manager), do the following:
```
sudo nixos-rebuild --upgrade switch
```
In order to update packages managed by home-manager, do the
following:
```
nix-channel --update
home-manager switch
```

### That rust.nix file in the root of the repo
I have not figured out enough nix to figure out what to do with this, but it's what I use whenever I am working with rust.
I place it in `~/Projects/` and do `nix-shell rust.nix`, then navigate to the project I want to work on.

## Kanagawa Theme Configuration

The Kanagawa theme is used throughout the environment for a cohesive look. It includes three variants:
- **Lotus** (light theme): Warm off-white backgrounds with earthy tones
- **Wave** (default dark): Deep ink-like backgrounds with ocean-inspired colors  
- **Dragon** (darker variant): Even deeper backgrounds for low-light environments

### Neovim Kanagawa Configuration

The Neovim setup includes custom airline themes that match the Kanagawa colorscheme.

#### Theme Files
- Airline themes: `nixpkgs/nvim/autoload/airline/themes/kanagawa_{lotus,wave,dragon}.vim`
- Auto-sync with colorscheme: Airline theme automatically changes when switching colorschemes
- Deferred loading fix: Ensures airline is fully loaded before applying theme

#### Keybindings
- `<leader>kt` - Cycle through all three Kanagawa themes
- `<leader>kl` - Switch to Kanagawa Lotus (light)
- `<leader>kw` - Switch to Kanagawa Wave (dark)
- `<leader>kd` - Switch to Kanagawa Dragon (darker)

#### Configuration Locations
- Main colorscheme setting: `nixpkgs/nvim/init.lua` (line 274)
- Airline theme config: `nixpkgs/nvim/lua/config/autocmds.lua` (line 134)
- Theme sync autocmd: `nixpkgs/nvim/lua/config/autocmds.lua` (lines 179-198)
- Deferred loading: `nixpkgs/nvim/lua/config/plugins.lua` (lines 177-196)
- Theme switcher: `nixpkgs/nvim/lua/config/keymaps.lua` (lines 143-165)

### Tmux Kanagawa Configuration

Three tmux theme files are available in `~/projects/claude-workspaces/`:

#### Kanagawa Lotus (Light) - `kanagawa-lotus-tmux.conf`
```bash
# Main colors
tmux_conf_theme_colour_1='#545464'    # lotusInk1 - dark gray (main foreground)
tmux_conf_theme_colour_2='#f2ecbc'    # lotusWhite3 - main background
tmux_conf_theme_colour_3='#716e61'    # lotusGray2 - medium gray
tmux_conf_theme_colour_4='#4d699b'    # lotusBlue4 - medium blue
tmux_conf_theme_colour_5='#77713f'    # lotusYellow - dark yellow

# Status line
tmux_conf_theme_status_bg='#e5ddb0'   # lotusWhite2
tmux_conf_theme_status_fg='#545464'   # lotusInk1

# Battery colors with good contrast
tmux_conf_battery_bar_palette='#6f894e,#8a8980,#e5ddb0'
```

#### Kanagawa Wave (Dark) - `kanagawa-wave-tmux.conf`
```bash
# Main colors
tmux_conf_theme_colour_1='#16161D'    # sumiInk0 - darkest background
tmux_conf_theme_colour_2='#1F1F28'    # sumiInk3 - default background
tmux_conf_theme_colour_3='#54546D'    # sumiInk6 - dim foreground
tmux_conf_theme_colour_4='#7E9CD8'    # crystalBlue - functions
tmux_conf_theme_colour_5='#E6C384'    # carpYellow - identifiers

# Status line
tmux_conf_theme_status_bg='#1F1F28'   # sumiInk3
tmux_conf_theme_status_fg='#DCD7BA'   # fujiWhite

# Battery colors
tmux_conf_battery_bar_palette='#98BB6C,#E6C384,#D27E99'
```

#### Kanagawa Dragon (Darker) - `kanagawa-dragon-tmux.conf`
```bash
# Main colors
tmux_conf_theme_colour_1='#0d0c0c'    # dragonBlack0 - darkest background
tmux_conf_theme_colour_2='#181616'    # dragonBlack3 - default background
tmux_conf_theme_colour_3='#625e5a'    # dragonBlack6 - lightest bg/dark gray
tmux_conf_theme_colour_4='#8ba4b0'    # dragonBlue2 - functions
tmux_conf_theme_colour_5='#c4b28a'    # dragonYellow - identifiers

# Status line
tmux_conf_theme_status_bg='#181616'   # dragonBlack3
tmux_conf_theme_status_fg='#c5c9c5'   # dragonWhite

# Battery colors
tmux_conf_battery_bar_palette='#87a987,#c4b28a,#a292a3'
```

#### Using Tmux Themes
To use a theme, source it in your `~/.tmux.conf.local`:
```bash
# For Lotus (light) theme
source-file ~/projects/claude-workspaces/kanagawa-lotus-tmux.conf

# For Wave (default dark) theme
source-file ~/projects/claude-workspaces/kanagawa-wave-tmux.conf

# For Dragon (darker) theme
source-file ~/projects/claude-workspaces/kanagawa-dragon-tmux.conf
```

Then reload tmux configuration with `<prefix>r` or:
```bash
tmux source-file ~/.tmux.conf
```

### Color Palette Reference

The Kanagawa theme is inspired by the famous painting "The Great Wave off Kanagawa" by Katsushika Hokusai. Each variant has distinct characteristics:

- **Lotus**: Paper-like warm whites, earthy greens, subtle blues - ideal for bright environments
- **Wave**: Deep ink blacks, ocean blues, foam whites - balanced for extended use
- **Dragon**: Even darker blacks, muted colors, lower contrast - perfect for late night coding
