{ config, pkgs, lib, ... }:

let
  imports = [
    ./git.nix
    ./shells.nix
    ./taskwarrior.nix
    ./vlc.nix
    ./tmux.nix
    ./i3.nix
    ./HighDpiCursor.nix
    ./alacritty.nix
    ./autorandr.nix
    ./bluetooth.nix
    ./spotify.nix
    ./rescuetime.nix
  ];
  vimConfig = builtins.readFile ./nvim/init.vim;
  ruststable = (pkgs.rust-bin.stable.latest.default.override { extensions = [
    "rust-src" "rust-analyzer-preview" "rust-analysis" "rustfmt-preview" ];});
  rustnightly = (pkgs.rust-bin.nightly.latest.default.override { extensions = [
    "rust-src" "rust-analyzer-preview" "rust-analysis" "rustfmt-preview" ];});
in
{
  # === programs settings ===
  programs = {
    # === HOME MANAGER SETTINGS ===
    # make sure home-manager is enabled
    home-manager = {
      # Let Home Manager install and manage itself.
      enable = true;
      path = "…";
    };

  };

  imports = imports;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rjected";
  home.homeDirectory = "/home/rjected";

  home.packages = with pkgs; [
    # add fish (fixes issue with nixpkgs#108897)
    fish

    # the basics
    firefox
    pciutils
    nodejs
    unzip
    imagemagick
    feh

    # age and pgp because i need simple sig verification
    age

    # zip
    zip

    # Monitoring and stuff
    gotop
    bpytop

    # signal!!
    signal-desktop

    # ug chrome
    # google-chrome
    minecraft

    usbutils

    monero-gui
    ledger-live-desktop

    # pdf editor best
    zathura
    minecraft

    # rg
    ripgrep

    # compilation stuff
    llvm
    bazel
    gnumake
    autoconf
    automake
    libtool
    autoreconfHook
    pkgconfig
    m4
    utillinux
    procps

    # Nodejs & tools

    # C++ & tools
    clang-tools
    cpplint
    ccls

    # Go & tools
    go
    # gopls
    # golangci-lint
    docker
    docker-compose
    podman
    skaffold
    kompose

    # docker-machine
    docker-machine
    docker-machine-kvm2

    # LaTeX & tools
    texlive.combined.scheme-full

    # node packages
    # nodePackages.bash-language-server

    # Python & tools
    python39Full
    python3Packages.pytest
    python3Packages.flake8
    python3Packages.pylint
    # python3Packages.python-language-server

    # Streaming
    obs-studio

    # arandr for fun
    arandr

    # this is a really amazing screenshot tool
    flameshot

    # some rust stuff
    act
    awscli2

    # we need audio control
    pavucontrol

    # ctags
    universal-ctags

    # minikube
    minikube

    # needing this is stupid just write tests in ur fav language
    postman

    geekbench
    # ugh electron apps
    discord

    # nvtop, also for fun
    nvtop
    mosh
    steam
    goimports
    ledger-live-desktop
    element-desktop

    # annoying programs
    zoom-us
    google-chrome

    # direnv for lorri
    direnv
    slack


    # btc stuff
    clightning
    bitcoind
  ];

  services.lorri.enable = true;

  # to fix a bug
  manual.manpages.enable = false;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    # extraConfig = vimConfig;
    withPython3 = true;
    coc = {
      enable = true;
      settings = {
        languageserver = {
          golang = {
            command = "gopls";
            rootPatterns = [
              "go.mod"
              ".vim/"
              ".git/"
              ".hg/"
            ];
            filetypes = [ "go" ];
            initializationOptions = {
              usePlaceholders = true;
              codelenses = {
                gc_details = true;
              };
              analyses = {
                unusedparams = true;
              };
              staticcheck = true;
            };
          };
          ccls = {
            command = "ccls";
            rootPatterns = [
              ".ccls"
              "compile_commands.json"
              ".vim/"
              ".git/"
              ".hg/"
            ];
            filetypes = [
              "c"
              "cpp"
              "objc"
              "objcpp"
            ];
            initializationOptions = {
              cache = {
                directory = "/tmp/ccls";
              };
            };
          };
          bash = {
            command = "bash-language-server";
            args = [ "start" ];
            filetypes = [ "sh" ];
            ignoredRootPaths = [ "~" ];
          };
          rust-analyzer = {
            serverPath = "${pkgs.rust-analyzer}/bin/rust-analyzer";
            rootPatterns = [
              "Cargo.toml"
              "Cargo.lock"
              ".git/"
              ".hg/"
            ];
            filetypes = [ "rs" ];
          };
        };
      };
    };
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      python3Packages.python-language-server
      rustnightly
      rust-analyzer
    ];
    # extraPython3Packages = (ps: with ps; [ python-language-server jedi ]);
  };
  xdg.configFile."nvim/init.vim" = {
    text = vimConfig;
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
