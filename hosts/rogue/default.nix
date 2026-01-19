{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/richard
    ../common/users/artisan

    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
  ];

  networking = {
    hostName = "rogue";
    useDHCP = true;
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  powerManagement.powertop.enable = true;
  programs.dconf.enable = true;

  hardware.graphics.enable = true;

  system.stateVersion = "25.11";
}
