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
Finally, symlink the `nixos` and `nixpkgs` directories into `/etc/nixos` and `~/.config/nixpkgs`
respectively:
```sh
ln -s ~/Projects/nix-configs/nixos/ /etc/nixos
ln -s ~/Projects/nix-configs/nixpkgs/ ~/.config/nixpkgs
```
Then, run `nixos-rebuild switch` and `home-manager switch`.

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