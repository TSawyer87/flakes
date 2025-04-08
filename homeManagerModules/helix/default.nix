{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = with pkgs; {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.helix;
    defaultEditor = true;
    extraPackages = [
      biome
      clang-tools
      helix-gpt
      nixpkgs-fmt
      nodePackages.prettier
      taplo-lsp
      vscode-langservers-extracted
      vscode-extensions.vadimcn.vscode-lldb
      yaml-language-server
      wl-clipboard-rs
      lldb
      scooter
    ];
    settings = {
      # theme = "kanagawa";

      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        line-number = "relative";
        true-color = true;
        default-yank-register = "+";

        soft-wrap.enable = true;

        auto-save = {
          focus-lost = true;
          after-delay.enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          ignore = false;
        };

        indent-guides = {
          character = "┊";
          render = true;
          skip-levels = 1;
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        statusline = {
          left = [
            "mode"
            "file-name"
            "spinner"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "file-type"
            "file-line-ending"
            "position"
          ];
          mode.normal = "";
          mode.insert = "I";
          mode.select = "S";
        };
      };
      keys = {
        normal = {
          H = ":buffer-previous";
          L = ":buffer-next";
          space = {"." = ":fmt";};
          C-g = [
            ":write-all"
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
            ":reload-all"
          ];
          C-r = [
            ":write-all"
            ":insert-output scooter >/dev/tty"
            ":redraw"
            ":reload-all"
          ];
          C-y = [
            ":sh rm -f /tmp/unique-file"
            ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
            ":insert-output echo '\x1b[?1049h\x1b[?2004h' > /dev/tty"
            ":open %sh{cat /tmp/unique-file}"
            ":redraw"
          ];
          space = {
            e = [
              ":sh rm -f /tmp/unique-file-h21a434"
              ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-h21a434"
              ":insert-output echo \"x1b[?1049h\" > /dev/tty"
              ":open %sh{cat /tmp/unique-file-h21a434}"
              ":redraw"
            ];
            E = [
              ":sh rm -f /tmp/unique-file-u41ae14"
              ":insert-output yazi '%{workspace_directory}' --chooser-file=/tmp/unique-file-u41ae14"
              ":insert-output echo \"x1b[?1049h\" > /dev/tty"
              ":open %sh{cat /tmp/unique-file-u41ae14}"
              ":redraw"
            ];
          };
        };
      };
    };

    # themes = {
    #   # https://github.com/helix-editor/helix/blob/master/runtime/themes/gruvbox.toml
    #   gruvbox_community = {
    #     inherits = "gruvbox";
    #     "variable" = "blue1";
    #     "variable.parameter" = "blue1";
    #     "function.macro" = "red1";
    #     "operator" = "orange1";
    #     "comment" = "gray";
    #     "constant.builtin" = "orange1";
    #     "ui.background" = { };
    #   };
    # };

    languages = {
      language-server.biome = {
        command = "biome";
        args = ["lsp-proxy"];
      };

      language-server.gpt = {
        command = "helix-gpt";
        args = ["--handler" "copilot"];
      };

      language-server.rust-analyzer.config = {
        check = {command = "clippy";};
        check.features = "all";
        check.always = true;
        cargo.toolchain = "nightly";
        cargo.buildScripts.rebuildOnSave = true;
        cargo.buildScripts.enable = true;
        cargo.autoreload = true;
        cargo.procMacro.enable = true;
        cargo.procMacro.ignored.leptos_macro = ["server" "component"];
        cargo.diagnostics.disables = ["unresolved-proc-macro"];
        cargo.allFeatures = true;
      };

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language = [
        {
          name = "css";
          language-servers = ["vscode-css-language-server" "gpt"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.css"];
          };
          auto-format = true;
        }
        # {
        #   name = "go";
        #   language-servers = [ "gopls" "golangci-lint-lsp" "gpt" ];
        #   formatter = { command = "goimports"; };
        #   auto-format = true;
        # }
        {
          name = "html";
          language-servers = ["vscode-html-language-server" "gpt"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.html"];
          };
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--indent-style"
              "space"
              "--stdin-file-path"
              "file.json"
            ];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--indent-style"
              "space"
              "--stdin-file-path"
              "file.jsonc"
            ];
          };
          file-types = ["jsonc" "hujson"];
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman" "gpt"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.md"];
          };
          auto-format = true;
        }
        # {
        #   name = "nix";
        #   formatter = {
        #     command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        #   };
        #   auto-format = true ;
        # }
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nil" "typos" "nixd"];
          formatter = {command = "${pkgs.alejandra}/bin/alejandra";};
        }
        # {
        #   name = "rust";
        #   language-servers = [ "rust-analyzer" "gpt" ];
        #   auto-format = true;
        # }
        {
          name = "nu";
          auto-format = true;
          formatter = {
            command = "topiary";
            args = ["format" "--language" "nu"];
          };
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer" "gpt"];
          scope = "source.rust";
          formatter = {
            command = "rustfmt";
            args = ["--edition=2024"];
          };
          comment-tokens = ["//" "///" "//!"];
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = ["vscode-css-language-server" "gpt"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.scss"];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {
            command = "taplo";
            args = ["fmt" "-o" "column_width=120" "-"];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.yaml"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
