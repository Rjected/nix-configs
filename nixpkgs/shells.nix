{config, lib, pkgs, ...}:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    download = "aria2c --file-allocation=none --seed-time=0";
    t = "task";
    k = "kubectl";
  };
in
{
  home.packages = with pkgs; [
    # programs used for shell stuff with aliases and everything else
    exa
    bat
    mosh
    aria
    taskwarrior
    kubectl
    yarn # used in vimrc
  ];

  programs.fish = {
    inherit shellAliases;
    enable = true;
  };
}
