{ config, pkgs, ... }:

let
  baseImports = [
    ./git.nix
    ./shells.nix
  ];
  laptopImports = [
    ./i3.nix
    ./HighDpiCursor.nix
    ./alacritty.nix
  ];
in
{
  # unfortunately not everything is free
  nixpkgs.config.allowUnfree = true;

  # === programs settings ===
  programs = {
    # === HOME MANAGER SETTINGS ===
    # make sure home-manager is enabled
    home-manager = {
      # Let Home Manager install and manage itself.
      enable = true;
      path = "…";
    };

    firefox = {
      enable = true;
    };

    neovim = {
      enable = true;
    };

  };

  # TODO: change this depending on the device. Use the same strategy to
  # determine which devices should be replicating the homedir and which ones
  # should be mere clients.
  imports = (baseImports ++ laptopImports);

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rjected";
  home.homeDirectory = "/home/rjected";

  # Add utilities such as bat
  home.packages = with pkgs; [
    # Monitoring and stuff
    htop

    # pdf editor best
    zathura

    # rg
    ripgrep

    # compilation stuff
    llvm

    # languages
    go
    texlive.combined.scheme-full
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
