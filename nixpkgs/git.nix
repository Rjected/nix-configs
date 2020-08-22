{config, lib, pkgs, ...}:

{
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
