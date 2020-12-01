{config, pkgs, ...}:

let
  kubeMasterIP = "100.90.44.114";
  kubeMasterHostname = "dan-nixos-sff";
  kubeMasterAPIServerPort = "8080";
in
{
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  # Enable kubernetes
  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${kubeMasterAPIServerPort}";
  in
  {
    roles = [ "node" ];
    masterAddress = kubeMasterHostname;

    kubelet.kubeconfig.server = api;
    apiserverAddress = api;
    addons.dns.enable = true;
    easyCerts = true;

    kubelet.extraOpts = "--fail-swap-on=false";
  };

}
