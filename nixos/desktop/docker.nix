{config, pkgs, ...}:
{
  # I want to use gvisor
  environment.systemPackages = [
    pkgs.v4l-utils
    pkgs.gvisor
    pkgs.gvisor-containerd-shim
    pkgs.containerd
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    extraOptions="--add-runtime containerd=${pkgs.containerd}/bin/containerd --add-runtime runsc=${pkgs.gvisor}/bin/runsc --dns 8.8.8.8 --dns 8.8.4.4";
  };

  networking.bridges.docker0 = {
    interfaces = [];
  };
  networking.networkmanager.unmanaged = [ "docker0" ];
}
