{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    cudatoolkit
    file
    pciutils
  ];

  # Create systemd service for cuda
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };
}
