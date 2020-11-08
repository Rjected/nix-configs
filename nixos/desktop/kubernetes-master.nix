{config, pkgs, ...}:
let
  kubeMasterIP = "100.90.44.114";
  kubeMasterHostname = "localhost";
  kubeMasterAPIServerPort = 443;
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # TODO: fix some issues with etcd not starting properly
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
  ];

  # Enable kubernetes
  services.kubernetes = {
    roles = ["master" "node"];
    addons.dns.enable = true;
    masterAddress = kubeMasterHostname;
  };

}
