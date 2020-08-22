{config, lib, pkgs, ...}:

let
  shellAliases = {
    l = "exa";
    ls = "exa";
    download = "aria2c --file-allocation=none --seed-time=0";
  };
in
{
  home.packages = with pkgs; [
    # programs used for shell stuff with aliases and everything else
    exa
    bat
    mosh
    aria
  ];

  programs.fish = {
    inherit shellAliases;
    enable = true;
    # promptInit = ''
    #   echo -e ""
    #   neofetch
    # '';
  };
}
