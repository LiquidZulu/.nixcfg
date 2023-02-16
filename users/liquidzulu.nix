{ hmUsers, ... }: {
  home-manager.users = { inherit (hmUsers) liquidzulu; };
  users.users.liquidzulu = {
    # Generated with mkpasswd
    initialHashedPassword =
      "$y$j9T$e/FwJ5/TYSGK/QSQaFwpm1$C.8bJyAIs3izAJz0tqvGK8.kS1NssZQNmOk7lO8GOiC";
    isNormalUser = true;
    description = "liquidzulu";
    createHome = true;
    extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
  };
}
