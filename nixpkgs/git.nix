{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    # Let's get gitandtools gh
    gitAndTools.gh
  ];

  programs.git = {
    enable = true;
    userName = "Dan Cline";
    userEmail = "dan@dancline.net";

    extraConfig = {
      core.editor = "nvim";
      pull.rebase = "true";
    };
  };
}
