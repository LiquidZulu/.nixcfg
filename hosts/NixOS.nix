{ config, lib, suites, profiles, diskoProfiles, ... }: {
  imports = lib.concatLists [
    suites.base
    [
      #/etc/nixos/hardware-configuration.nix
      diskoProfiles.NixOS
    ]
    (with profiles.editing; [
      # File editing
      #natron # broken right now, using distrobox instead
      gimp
      writing
      kdenlive
      audacity
      lmms
      blender
    ])
    (with profiles.git; [
      # Anything to do with git, ~except git itself which is users.profiles.git~
      git
      github-desktop
    ])
    (with profiles.terminal; [
      # Terminal emulator(s)
      alacritty
      kitty
    ])
    (with profiles; [
      # Scripts and shells
      sh
      scripts.bat
      scripts.cbonsai
      scripts.cmatrix
      #scripts.colorscript
      scripts.exa
      scripts.thefuck
      scripts.fd
      scripts.file
      scripts.fzf
      scripts.gdu
      scripts.hollywood
      scripts.pomodoro
      scripts.rg
      scripts.xmessage
      scripts.zoxide
    ])
    (with profiles.package-managers; [
      # Package Managers
      apx
      yarn
      pip
    ])
    (with profiles.tools; [
      # Tools
      cmake
      lefthook
      libtool
      libuuid
      ngrok
      gpg
      pkg-config
    ])
    (with profiles.drivers;
      [
        # Drivers
        printer
      ])
    (with profiles.languages; [
      # Languages
      javascript
      sqlite
      python
      rust
    ])
    (with profiles; [
      # Web
      browsers
      torrent

      # VOIP applications
      voip

      # File browser(s)
      dolphin

      # Media recording/playback
      flameshot
      obs
      vlc
      mpv

      # Run launcher
      launcher

      # Networking
      networking
      vpn

      # Window Manager
      wm

      # Download scripts
      ytdl

      # Fonts
      fonts

      # Fetch commands
      fetch

      # Task Management
      htop
      nvtop

      # Misc
      ledger
      vcv
      openai
      cuda
      wine
      audio
      io
    ])
  ];

  # Misc
  time.timeZone = "Europe/London";

  # Boot
  boot = {

    # sysctl settings
    kernel.sysctl = {
      "vm.max_map_count" =
        2147483642; # https://www.youtube.com/watch?v=PsHRbfZhgXM
    };

    # Bootloader
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        enableCryptodisk = true;
        efiSupport = true;
      };
    };

    # NTFS support
    supportedFilesystems = [ "ntfs" ];

    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Services
  services = {

    flatpak.enable = true;

    # X11 Keymap
    xserver = {
      layout = "gb";
      xkbVariant = "";
    };

    # Automatic login
    xserver.displayManager.autoLogin = {
      enable = true;
      user = "liquidzulu";
    };

    # Allow CUPS to print documents
    printing.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Nixpkgs config
  nixpkgs = {

    config = {
      # Allow unfree packages
      allowUnfree = true;

      # Allow broken packages
      #allowBroken = true;

      # Allow insecure packages
      permittedInsecurePackages = [
        "openssl-1.1.1v" # for some reason they are shipping an out of date openssl
      ];
    };

    # Specify the platform where the NixOS configuration will run.
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  # Hardware
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # ( e.g. man configuration.nix or on https://nixos.org/nixos/options.html ).
  system.stateVersion = "22.11"; # Did you read the comment?
}
