{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../features/cli
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "artisan";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "25.11";
    sessionPath = ["$HOME/.local/bin"];
  };
}
