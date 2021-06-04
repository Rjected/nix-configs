{config, pkgs, ...}:
{

  # Use NetworkManager for networking
  networking.networkmanager.enable = true;

  # add to NetworkManager group
  users.users.rjected.extraGroups = [ "networkmanager" ];

}
