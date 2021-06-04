{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    # Let's get gh
    gitAndTools.gh
    gitAndTools.delta
    bat
    less
  ];

  programs.git = {
    enable = true;
    userName = "Dan Cline";
    userEmail = "dan@dancline.net";

    extraConfig = {
      core = {
        pager = "delta";
        editor = "nvim";
      };
      delta = {
        features = "side-by-side line-numbers decorations";
        whitespace-error-style = "22 reverse";
      };
      init.defaultBranch = "main";
      pull.rebase = "true";
      interactive.diffFilter = "delta --color-only";
    };
  };
}
