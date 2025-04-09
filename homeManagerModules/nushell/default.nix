{
  pkgs,
  lib,
  ...
}: {
  config = {
    programs = {
      carapace.enable = true;
      carapace.enableNushellIntegration = true;
      atuin.enable = true;
      atuin.enableNushellIntegration = true;
      # direnv = {
      #   enable = true;
      #   # enableNushellIntegration = true;
      #   nix-direnv.enable = true;
      # };

      nushell = {
        enable = true;
        configFile.source = ./config.nu;
        shellAliases = let
          g = lib.getExe pkgs.git;
          c = "cargo";
        in {
          # Cargo
          cb = "${c} build";
          cc = "${c} check";
          cn = "${c} new";
          cr = "${c} run";
          cs = "${c} search";
          ct = "${c} test";
          repl = "evcxr";

          # Git
          ga = "${g} add";
          gc = "${g} commit";
          gd = "${g} diff";
          gl = "${g} log";
          gs = "${g} status";
          gp = "${g} push origin main";

          # ETC.
          c = "clear";
          yz = "${pkgs.yazi}/bin/yazi";
          la = "ls -la";
          ll = "ls -l";
          n = "${pkgs.nitch}/bin/nitch";
          vi = "nvim";
          zd = "zeditor";
          fz = "fzf --bind 'enter:become(hx {})'";

          # Nix
          # fr = "nh os switch --hostname magic /home/jr/flakes";
          fr = "nh os switch /home/jr/flakes";
          ft = "nh os test --hostname magic /home/jr/flakes";
          fu = "nh os switch --hostname magic --update /home/jr/flakes";
          opts = "man home-configuration.nix";

          cat = "${pkgs.bat}/bin/bat";
          df = "${pkgs.duf}/bin/duf";
          find = "${pkgs.fd}/bin/fd";
          grep = "${pkgs.ripgrep}/bin/rg";
          tree = "${pkgs.eza}/bin/eza --git --icons --tree";
        };

        environmentVariables = {
          STARSHIP_SHELL = "nu";
          PROMPT_INDICATOR = "";
          PROMPT_INDICATOR_VI_INSERT = ": ";
          PROMPT_INDICATOR_VI_NORMAL = "> ";
          PROMPT_MULTILINE_INDICATOR = "::: ";
          DIRENV_LOG_FORMAT = ''""''; # make direnv quiet
          # SHELL = ''"${pkgs.nushell}/bin/nu"'';
          # EDITOR = ''"hx"'';
          EDITOR = "hx";
          VISUAL = "hx";
          MANPAGER = "nvim +Man!";
        };

        # See the Nushell docs for more options.
        extraConfig = let
          conf = builtins.toJSON {
            show_banner = false;
            edit_mode = "vi";
            # completions.external.completer = {|span| carapace_by_fzf $span };
            # shell_integration = true;

            ls.clickable_links = true;
            rm.always_trash = true;

            table = {
              mode = "rounded";
              index_mode = "always";
              header_on_separator = false;
            };

            cursor_shape = {
              vi_insert = "line";
              vi_normal = "block";
            };

            menus = [
              # {
              #   name = "my_history_menu";
              #   only_buffer_difference = false;
              #   marker = "";
              #   # type = {layout = ide};
              # }
              {
                name = "completion_menu";
                only_buffer_difference = false;
                marker = "? ";
                type = {
                  layout = "columnar"; # list, description
                  columns = 4;
                  col_padding = 2;
                };
                style = {
                  text = "magenta";
                  selected_text = "blue_reverse";
                  description_text = "yellow";
                };
              }
            ];
          };
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
          completions = names:
            builtins.foldl'
            (prev: str: ''
              ${prev}
              ${str}'') ""
            (map completion names);
        in ''
                      $env.config = ${conf};
                      ${completions ["git" "nix" "man" "cargo"]}

                      def --env yy [...args] {
                      	let tmp = (mktemp -t "yazi-cwd.XXXXX")
                      	yazi ...$args --cwd-file $tmp
                      	let cwd = (open $tmp)
                      	if $cwd != "" and $cwd != $env.PWD {
                      		cd $cwd
                      	}
                      	rm -fp $tmp
                      }

                      def to-group-name [] {
            str replace -ra "[()'\":,;|]" "" |
            str replace -ra '[\.\-\s]' "_"
          }

          export def jj-nu-log [
            --revset (-r): string
            ...columns: string
          ] {
            let columns = $columns | each {
              match $in {
                "description" => "description.lines().join(',')"
                _ => $in
              }
            }
            let parser = $columns | each { $"{($in | to-group-name)}" } | str join (char rs)

            ( jj log ...(if $revset != null {[-r $revset]} else {[]})
                 --no-graph
                 -T $"($columns | str join $"++'(char rs)'++") ++ '\n'"
            ) |
            parse $parser
          }
        '';
      };
    };
  };
}
