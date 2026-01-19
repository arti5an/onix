{
  config,
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.COLORTERM = "truecolor";

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        soft-wrap.enable = true;
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
          formatter.command = "alejandra";
        }
        {
          name = "json";
          language-servers = ["colors"];
        }
      ];
      language-server = {
        tinymist.config = {
          typstExtraArgs = ["main.typ"];
          exportPdf = "onType";
          outputPath = "$root/$name";
        };

        scls.command = lib.getExe pkgs.simple-completion-language-server;
        colors.command = lib.getExe pkgs.uwu-colors;
      };
    };
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
