{config, pkgs, ...}:
{
  environment.systemPackages = [
    # pkgs.containerd
  ];

  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune.enable = true;
    # extraOptions="--add-runtime containerd=${pkgs.containerd}/bin/containerd --add-runtime runsc=${pkgs.gvisor}/bin/runsc --dns 8.8.8.8 --dns 8.8.4.4";
    # extraOptions="--add-runtime containerd=${pkgs.containerd}/bin/containerd";
  };

  # networking.bridges.docker0 = {
  #   interfaces = [
  #     "wlp3s0"
  #   ];
  # };
  # networking.networkmanager.unmanaged = [ "docker0" ];
}
