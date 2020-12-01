{config, lib, pkgs, ...}:

{
  home.packages = with pkgs; [
    rescuetime
  ];

 systemd.user.services.rescuetime-daemon = {
   serviceConfig = {
     Type = "forking";
     ExecStart = "${pkgs.rescuetime}/bin/rescuetime";
     ExecStop = "pkill rescuetime";
     Restart = "on-failure";
   };
   wantedBy = [ "default.target" ];
 };

 systemd.user.services.rescuetime-daemon.enable = true;
}
