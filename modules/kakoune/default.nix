{ config, pkgs, ... }:

{
  home.file.".config/kak/smarttab.kak".source = builtins.fetchurl {
    url = https://raw.githubusercontent.com/andreyorst/smarttab.kak/master/rc/smarttab.kak;
    sha256 = "1xqljpv4jy7c42yh4h4xp8r3j3k0xn20yagi0dscdv2gpgqgsjn3";
  };
  home.file.".config/kak/copy_to_system_clipboard.kak".source = ./copy_to_system_clipboard.kak;
  home.file.".config/kak/disable_auto_indent.kak".source = ./disable_auto_indent.kak;

  home.packages = with pkgs; [ rustfmt nixfmt python39Packages.mdformat shfmt yamlfix ];

  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./sources.kak;
    config = {
      colorScheme = "gruvbox-dark";
      wrapLines = {
        enable = true;
        indent = true;
        marker = "⏎";
        word = true;
      };
      numberLines.enable = true;
      showWhitespace.enable = true;
      # From https://gist.github.com/fufexan/377b975835c3580ab3484f1aa8a67a81
      hooks = [
        {
          # tab completion
          name = "InsertCompletionShow";
          option = ".*";
          commands = ''
            try %{
              # this command temporarily removes cursors preceded by whitespace;
              # if there are no cursors left, it raises an error, does not
              # continue to execute the mapping commands, and the error is eaten
              # by the `try` command so no warning appears.
              execute-keys -draft 'h<a-K>\h<ret>'
              map window insert <tab> <c-n>
              map window insert <s-tab> <c-p>
              hook -once -always window InsertCompletionHide .* %{
                map window insert <tab> <tab>
                map window insert <s-tab> <s-tab>
              }
            }
          '';
        }

        # languages
          name = "BufSetOption";
          option = "filetype=nix";
          commands = ''
            expandtab
            set-option buffer softtabstop 2
            set-option buffer tabstop 2
            set-option buffer indentwidth 2
            # formatting
            set-option buffer formatcmd nixfmt
          '';
        }
        {
          name = "BufSetOption";
          option = "filetype=sh";
          commands = ''
            noexpandtab
            set-option buffer softtabstop 2
            set-option buffer tabstop 2
            set-option buffer indentwidth 2
            evaluate-commands %sh{
              if which shfmt > /dev/null; then
                echo 'set-option buffer formatcmd shfmt'
              fi
            }
          '';
        }
        {
          name = "BufSetOption";
          option = "filetype=justfile";
          commands = ''
            noexpandtab
            set-option buffer softtabstop 4
            set-option buffer tabstop 4
            set-option buffer indentwidth 4
          '';
        }
        {
          name = "BufSetOption";
          option = "filetype=yaml";
          commands = ''
            expandtab
            set-option buffer softtabstop 2
            set-option buffer tabstop 2
            set-option buffer indentwidth 2
            # formatting
            set-option buffer formatcmd yamlfix
          '';
        }
      ];
    };
    plugins = with pkgs.kakounePlugins; [
      kak-lsp tabs-kak pandoc-kak kakoune-rainbow
    ];
  };
}

