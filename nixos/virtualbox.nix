{config, pkgs, ...}:
{
  virtualisation.virtualbox.host.enable = true;
  users.user.rjected.extraGroups = [ "user-with-access-to-virtualbox" ];
}
