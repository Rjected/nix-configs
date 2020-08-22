{config, lib, pkgs, ...}:

let
  go-cast = pkgs.callPackage (builtins.fetchTarball {
      url = "https://github.com/rjected/go-cast/archive/df48bea685.tar.gz";
      sha256 = "0xka0q3f7axrglckaxbmh0cwpad1r7kc1im4alfhw9vp90j81xyh";
    }) {};
  })
  shellAliases = {
    cast-screen = "${go-cast}/bin/cast --name DanScreenj";
    cast = "${go-cast}/bin/cast";
  };
in
{
  # Set the above aliases in fish
  programs.fish = {
    inherit shellAliases;
  };
}
