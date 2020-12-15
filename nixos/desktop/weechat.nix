{ config, pkgs, ... }:
let
  plugins = builtins.concatStringsSep "," [
    "charset"
    "irc"
    "logger"
    "relay"
    "weechat"
  ];
  commands = builtins.concatStringsSep "," [
    "join"
    "nick"
    "whois"
    "part"
    "close"
    "list"
    "me"
    "query"
    "msg"
    "server"
    "connect"
    "disconnect"
    "topic"
    "invite"
    "mode"

    # needed for buffer state tracking (e.g. unread count)
    "buffer"
    "input" # https://github.com/glowing-bear/glowing-bear/pull/601/files
  ];

              #/secure passphrase ${(import ./secrets.nix).irc.passphrase}
in
{
  nixpkgs = {
    config = {
      packageOverrides = pkgs: rec {
        # https://nixos.org/nixpkgs/manual/#sec-weechat
        weechat = pkgs.weechat.override {
          configure = {availablePlugins, ...}: {
            init = ''
              /set logger.file.path /var/log/weechat-headless/channels/
              /set relay.network.password ${(import ./secrets.nix).irc.relay}
              /set relay.weechat.commands "${commands}"
              /relay add weechat 9001
              /server add freenode chat.freenode.net/6697 -ssl -autoconnect
              /secure set freenode_username ${(import ./secrets.nix).irc.freenode.username}
              /secure set freenode_password ${(import ./secrets.nix).irc.freenode.password}
              /set irc.server.freenode.nicks \''${sec.data.freenode_username}
              /set irc.server.freenode.sasl_mechanism PLAIN
              /set irc.server.freenode.sasl_username \''${sec.data.freenode_username}
              /set irc.server.freenode.sasl_password \''${sec.data.freenode_password}
              /set irc.server.freenode.autojoin "#btcd,#bitcoin-core-pr-reviews,#utreexo"
              /connect freenode
            '';
          };
        };
      };
    };
  };

  systemd.services.weechat-headless = {
    environment.WEECHAT_HOME = "/tmp"; # uses private tmp
    description = "Weechat Headless";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      DynamicUser = true;
      Restart = "on-failure";
      LogsDirectory = "weechat-headless";
      ExecStart = "${pkgs.weechat}/bin/weechat-headless --stdout --plugins '${plugins}'";
      NoNewPrivileges = true;
      PrivateDevices = true;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "irc.dancline.net" = {
        serverName = "irc.dancline.net";
        forceSSL = false;
        enableACME = false;
        locations = {
          "/weechat" = {
            proxyPass = "http://127.0.0.1:9001/weechat";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_read_timeout 4h;
            '';
          };
          "/".root = pkgs.glowing-bear;
        };
      };
    };
  };
}
