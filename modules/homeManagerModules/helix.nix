{ pkgs, ... }: {
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      bash-language-server
      biome
      clang-tools
      helix-gpt
      marksman
      nil
      nixd
      nixpkgs-fmt
      nodePackages.prettier
      # sql-formatter
      rust-analyzer
      taplo
      taplo-lsp
      vscode-langservers-extracted
      yaml-language-server
      wl-clipboard-rs
    ];
    settings = {
      theme = "dracula";

      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        line-number = "relative";
        true-color = true;

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
          space = {
            "." = ":fmt";
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
        args = [ "lsp-proxy" ];
      };

      language-server.gpt = {
        command = "helix-gpt";
        args = [ "--handler" "copilot" ];
      };

      language-server.rust-analyzer.config.check = { command = "clippy"; };

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language = [
        {
          name = "css";
          language-servers = [ "vscode-css-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.css" ];
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
          language-servers = [ "vscode-html-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.html" ];
          };
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
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
              except-features = [ "format" ];
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
          file-types = [ "jsonc" "hujson" ];
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "marksman" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.md" ];
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
          language-servers = [ "nil" "typos" ];
          formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
        }
        # {
        #   name = "rust";
        #   language-servers = [ "rust-analyzer" "gpt" ];
        #   auto-format = true;
        # }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" "gpt" ];
          formatter = {
            command = "rustfmt";
            args = [ "--edition=2024" ];
          };
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = [ "vscode-css-language-server" "gpt" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.scss" ];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = [ "taplo" ];
          formatter = {
            command = "taplo";
            args = [ "fmt" "-o" "column_width=120" "-" ];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.yaml" ];
          };
          auto-format = true;
        }
      ];
    };
  };
}
