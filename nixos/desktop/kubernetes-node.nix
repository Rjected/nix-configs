{config, pkgs, ...}:
let
  kubeMasterIP = "100.90.44.114";
  kubeMasterHostname = "dan-nixos-sff";
  kubeMasterAPIServerPort = "8080";
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # TODO: fix some issues with etcd not starting properly
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
  ];

  # Enable kubernetes
  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${kubeMasterAPIServerPort}";
  in
  {
    roles = ["node"];
    apiserverAddress = api;
    masterAddress = kubeMasterHostname;
    easyCerts = true;
    addons.dns.enable = true;
    kubelet = {
      kubeconfig.server = api;
      extraOpts = "--fail-swap-on=false";
    };
  };

}
