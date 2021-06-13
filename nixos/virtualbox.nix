{config, pkgs, ...}:
{
  virtualisation.virtualbox.host.enable = true;
  users.users.rjected.extraGroups = [ "user-with-access-to-virtualbox" ];
}
