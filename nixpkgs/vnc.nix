{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    # tiger vnc
    tigervnc
  ];
}
