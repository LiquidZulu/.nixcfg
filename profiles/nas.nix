{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [ synology-drive-client ]; # this didnt work, I use flatpak now

  network = {

    # See: https://kb.synology.com/en-global/DSM/tutorial/What_network_ports_are_used_by_Synology_services
    firewall = {
      enable = true;

      allowedTCPPorts = [

        22 # Synology SSH encryption port

        # Backup → Active Backup for Business
        #443  # vCenter Server and ESXi host
        #445  # SMB for Hyper-V host
        #902  # ESXi host
        #5510 # Synology NAS
        #5985 # HTTP for Hyper-V host
        #5986 # HTTPS for Hyper-V host

        # Backup → Data Replicator, Data Replicator II, Data Replicator III
        9999
        9998
        9997
        137
        138
        139
        445

        # Backup → DSM 5.2 Data Backup, rsync, Shared Folder Sync, Remote Time Backup
        873

        # Backup → Hyper Backup (destination)
        6281 # multi-version backup
        873 # remote data copy

        # Backup → Hyper Backup Vault, DSM 5.2 Archiving Backup
        6281

        # Backup → LUN Backup
        3260 # iSCSI
        873

        # Backup → Snapshot Replication
        3261 # iSCSI LUN
        5566 # shared folder

        # Download → BT
        16881 # for DSM 2.0.1 or above

        # Download → eMule
        4662

        # Mail Service → *
        #143 # IMAP
        #993 # IMAP over SSL/TLS
        #110 # POP3
        #995 # POP3 over SSL/TLS
        #25  # SMTP
        #465 # SMTP-SSL
        #587 # SMTP-TLS

        # File Transferring → AFP
        548

        # File Transferring → CIFS
        139 # netbios-ssn
        445 # microsoft-ds
        137
        138

        # File Transferring → FTP, FTP over SSL, FTP over TLS
        21 # command
        20 # data connection in Active Mode

        # File Transferring → iSCSI
        3260
        3263
        3265

        # File Transferring → NFS
        111
        892
        2049

        # File Transferring → WebDAV, CalDAV
        5005
        5006 # HTTPS

        # Packages → File Station
        5000 # HTTP
        5001 # HTTPS

        # Packages → Log Center
        514

        # Packages → Synology Drive Server
        80 # link sharing
        443 # link sharing
        5000 # HTTP
        5001 # HTTPS
        6690 # 6690
      ];

      allowedUDPPorts = [

        # Download → eMule
        4672

        # File Transferring → CIFS
        139 # netbios-ssn
        445 # microsoft-ds

        # File Transferring → NFS
        111
        892
        2049

        # File Transferring → TFTP
        69

        # Packages → Log Center
        514
      ];

      allowedTCPPortRanges = [
        # Download → BT → for DSM 2.0.1-3.0401 or earlier version
        {
          from = 6890;
          to = 6999;
        }

        # File Transferring → FTP, FTP over SSL, FTP over TLS → data connection in Passive Mode
        {
          from = 1025;
          to = 65535;
        }
      ];

      allowedUDPPortRanges = [
        # Synology Assistant
        {
          from = 9997;
          to = 9999;
        }

        # Download → BT → for DSM 2.0.1-3.0401 or earlier version
        {
          from = 6890;
          to = 6999;
        }
      ];
    };
  };
}
