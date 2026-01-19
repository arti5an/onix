{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.richard = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "network"
      "plugdev"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];

    hashedPassword = "$6$YSQKtWp3CE9PMoSN$xjCl/cHEtGz0FGQ8br1LqvRxNe6hr7UoNZUnatCJGKO2UcBIvktuxc5XHVMnx29jc/EZ8I3V.uqfjAO8WPKZA0";
    packages = [pkgs.home-manager];
  };

  home-manager.users.richard = import ../../../../home/richard/${config.networking.hostName}.nix;
}
