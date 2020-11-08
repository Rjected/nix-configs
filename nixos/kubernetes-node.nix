{config, pkgs, ...}:

let
  kubeMasterIP = "100.90.44.114";
  kubeMasterHostname = "nixos-dan-sff";
  kubeMasterAPIServerPort = 443;
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
  in {
    roles = [ "node" ];
    masterAddress = kubeMasterHostname;

    kubelet.kubeconfig.server = api;
    apiserverAddress = api;
    addons.dns.enable = true;

    kubelet.extraOpts = "--fail-swap-on=false";
  };

}
