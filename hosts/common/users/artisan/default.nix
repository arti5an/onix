{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.artisan = {
    uid = 1024;
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
      "wheel" # temporary
      "wireshark"
    ];

    hashedPassword = "$6$rrPjp8wKKcN6ETsi$c6u//AGn4VujYvgeC0F9gsnJcieuOAKN/usI2qTL6qyVeZ5bBEJHPUJYjf.ZWFL56ncVoM8TGGrpNHAk8Wwm.0";
    packages = [pkgs.home-manager];
  };

  home-manager.users.artisan = import ../../../../home/artisan/${config.networking.hostName}.nix;
}
