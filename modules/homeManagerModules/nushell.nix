{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    zoxide
  ];

  programs.nushell = {
    enable = true;
    environmentVariables = config.home.sessionVariables;
    extraConfig = ''
      $env.config.show_banner = false
      $env.config.buffer_editor = "hx"
      $env.config.edit_mode = "vi"

      let carapace_completer = {|spans: list<string>|
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
      }

      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

      let fish_completer = {|spans|
          ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
      }

      let zoxide_completer = {|spans|
          $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
      }

      let multiple_completers = {|spans|
          let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

          let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
          } else {
              $spans
          }

          match $spans.0 {
              z | zi => $zoxide_completer
              _ => $carapace_completer
          } | do $in $spans
      }

      $env.config.completions = {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: {
              enable: true
              max_results: 100
              completer: $multiple_completers
          }
      }
    '';
    plugins = lib.attrValues {
      inherit (pkgs.nushellPlugins)
        formats gstat polars query;
    };
    shellAliases = {
      docker-compose = "podman-compose";
      ls = "eza --grid --icons --group-directories-first --all";
      jq = "jaq";
      vi = "nvim";
      vk = "NVIM_APPNAME='kick' nvim";
    };
  };
}
