{pkgs, ...}: {
  imports = [
    ../../../features/cli
    ./git.nix
    ./nix-index.nix
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    distrobox # Docker based escape hatch for running virtually anything

    nixd # Nix LSP
    alejandra # Nix formatter
    nvd # Nix differ
    nix-diff # More detailed nix differ
    nix-output-monitor
    nh # Nice wrapper for NixOS and Home Manager
  ];
}
