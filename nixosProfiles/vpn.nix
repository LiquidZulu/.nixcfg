{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    protonvpn-gui
    openvpn
    wireguard-tools
    strongswan
  ];

  networking = {
    wg-quick.interfaces = {
      "ch-uk" = {
        autostart = false;
        address = [ "10.2.0.2/32" ];
        privateKeyFile = "/home/liquidzulu/vpn/ch-uk.key";
        dns = [ "10.2.0.1" ];

        peers = [
          {
            publicKey = "7tEhXa2x1eKGbPevwzPjo5u5HLshPxwkofSII9y0v2c=";
            allowedIPs = [ "0.0.0.0/0" "::/0" ];
            endpoint = "62.169.136.229:51820";
            persistentKeepalive = 25;
          }
        ];

        # preUp = ''
        #   ${pkgs.iproute2}/bin/ip rule add not from 10.2.0.2 table 100
        #   ${pkgs.iproute2}/bin/ip route add table 100 0.0.0.0/0 via 10.2.0.1 dev ch-uk
        # '';
        # postDown = ''
        #   ${pkgs.iproute2}/bin/ip rule del not from 10.2.0.2 table 100
        # '';
      };
    };
  };

  #systemd.services."wg-quick-ch-uk".wantedBy = [ "multi-user.target" ];
}
