{
  nix = {
    settings = {
      # Prevent impurities in builds
      sandbox = true;

      # Give root user and wheel group special Nix privileges.
      trusted-users = [
        "root"
        "@wheel"
      ];
      allowed-users = [ "@wheel" ];

      auto-optimise-store = true;
    };

    # Improve nix store disk usage
    optimise.automatic = true;

    # Improve nix store disk usage
    gc.automatic = true;

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };
}
