{pkgs, ...}: {
  imports = [
    ../../../features/cli
    ./git.nix
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    distrobox # Docker based escape hatch for running virtually anything
  ];
}
