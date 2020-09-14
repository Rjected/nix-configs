{ config, pkgs, ... }:

let
  baseImports = [
    ./git.nix
    ./shells.nix
    ./vnc.nix
  ];
  laptopImports = [
    ./i3.nix
    ./HighDpiCursor.nix
    ./alacritty.nix
    ./autorandr.nix
    ./bluetooth.nix
    ./spotify.nix
    ./google-cast.nix
    ./rescuetime.nix
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
    # the basics
    firefox
    neovim
    pciutils
    nodejs
    unzip
    imagemagick
    feh

    # Monitoring and stuff
    htop
    bpytop

    # weechat
    weechat
    # https://www.reddit.com/r/siacoin/comments/iox6ly/proposal_the_sia_foundation/

    # signal!!
    signal-desktop

    # ug chrome
    google-chrome

    # pdf editor best
    zathura

    # rg
    ripgrep

    # compilation stuff
    llvm
    bazel
    bear
    gnumake
    autoconf
    automake
    libtool
    autoreconfHook
    pkgconfig
    m4
    utillinux

    # Nodejs & tools

    # C++ & tools
    clang-tools
    clang
    cpplint
    ccls

    # Go & tools
    go
    gopls
    golangci-lint
    docker

    # LaTeX & tools
    texlive.combined.scheme-full

    # Python & tools
    python39Full
    python3Packages.pytest
    python3Packages.flake8
    python3Packages.pylint
    python3Packages.jedi
    # python3Packages.python-language-server

    # arandr for fun
    arandr

    # this is a really amazing screenshot tool
    flameshot

    # we need audio control
    pavucontrol
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
