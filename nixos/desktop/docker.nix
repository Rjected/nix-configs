{config, pkgs, ...}:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    extraOptions="--dns 8.8.8.8 --dns 8.8.4.4 --bridge virbr0";
  };
}
