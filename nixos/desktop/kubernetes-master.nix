{config, pkgs, ...}:
let
  kubeMasterIP = "100.90.44.114";
  kubeMasterHostname = "dan-nixos-sff";
  kubeMasterAPIServerPort = 8080;
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
    apiserver.insecurePort = 8080;
    addons.dns.enable = true;
    addons.dashboard.enable = true;
    masterAddress = kubeMasterHostname;
    easyCerts = true;
    kubelet = {
      extraOpts = "--fail-swap-on=false";
    };
  };

}
