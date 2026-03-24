{ config, lib, pkgs, ... }:

{
  services.declarative-jellyfin = {
    enable = true;

    libraries."Watch Together" = {
      enabled = true;
      contentType = "movies";
      pathInfos = [ "/srv/jellyfin-media/watch-together" ];
    };

    # Optional: declarative admin user
    users = {
      admin = {
        mutable = false;
        permissions.isAdministrator = true;
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$283E51338737479C2BD1419FBDFDDCF2$7EB747BEA6EF59999E693789D6421522EA75F299D2E7F31D335960263170019C10899474F5D78B6D12122F95B9F548315DCB58C68884677E64EF417A961C0C90";
        # hashedPasswordFile = "/run/secrets/jellyfin-pass"; # use sops-nix if you want
      };

      guest = {
        mutable = false;
        password = "";
      };

      guest1 = {
        mutable = false;
        password = "";
      };

      guest2 = {
        mutable = false;
        password = "";
      };

      guest3 = {
        mutable = false;
        password = "";
      };

      Galazar = {
        mutable = false;
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$EC0342AACAE3F46A40EA72516820C0E8$768440E50A80C9C4A70C3765B41438EFA1966C98C4D28AB8DB0715527F35E1B8FC31CA8B81C02ED33BE886A0F81F017AEAAD78AC5467A03815D96122733EFCFA";
      };

      MonHop = {
        mutable = false;
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$3124640230DF60D304C30FF1731A7331$DBF72C161DE48C2F523B985A59CC5468F6B643EE6DB0B31451704C375440B7267A4C8E3EAE9F4578666A2E317E86F51C1510101AB06997D9CF85561859F46878";
      };

      "Rational Frontier" = {
        mutable = false;
        hashedPassword = "$PBKDF2-SHA512$iterations=210000$E94E89DCAFBD60D201CB5A770A0B8323$70AC2AFC14C45F08897E7452C12BA473AD16850B29DD87EBE775DA56ACFD1C398A5C69486F9410FDDF2080C484C1209C707019869A35E72593768066D9CC9A1D";
      };
    };

    system = {
      serverName = "LiquidZulu Stream Watch Together";
      #requireHttps = true;
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = lib.mkDefault "liquidzulu";  # strongly recommended – avoids permission headaches
  };

  # Create the media folder
  systemd.tmpfiles.rules = [
    # Existing media dir (keep yours, but update group if needed)
    "d /srv/jellyfin-media/watch-together 0775 liquidzulu users - -"

    # Critical: Create Jellyfin's data/working dir + common subdirs
    "d /var/lib/jellyfin                  0755 liquidzulu users - -"
    "Z /var/lib/jellyfin                  0755 liquidzulu users - -"  # recursive chown/chmod if exists
    "d /var/lib/jellyfin/cache            0775 liquidzulu users - -"
    "d /var/lib/jellyfin/config           0755 liquidzulu users - -"
    "d /var/lib/jellyfin/data             0755 liquidzulu users - -"
    "d /var/lib/jellyfin/log              0775 liquidzulu users - -"
    "d /var/lib/jellyfin/metadata         0755 liquidzulu users - -"
    "d /var/lib/jellyfin/plugins          0755 liquidzulu users - -"
  ];

  environment.systemPackages = with pkgs; [ jellyfin-ffmpeg ];
}
