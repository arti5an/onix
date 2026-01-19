{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./git.nix
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    comma # Shortcut to install and run programs by prefixing a ,
    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    eza # Fancier ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    viddy # Better watch
  ];
}
