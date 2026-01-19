{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      aliases = {
        graph = "log --decorate --oneline --graph";
      };
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      push.autoSetupRemote = true; # Automatically track remote branch
      rerere.enabled = true; # Reuse merge conflict fixes when rebasing
    };
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
