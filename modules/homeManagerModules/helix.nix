{ config, pkgs, ... }:

let
  helix-nightly = pkgs.stdenv.mkDerivation rec {
    pname = "helix";
    version = "nightly"; # Or use a timestamp or dynamic version
    src = builtins.fetchTarball {
      url = "https://github.com/helix-editor/helix/archive/refs/heads/nightly.tar.gz";
    };

    nativeBuildInputs = [ pkgs.cargo pkgs.pkg-config pkgs.rustc ];

    # Depending on what dependencies Helix needs, you can add more inputs
    buildInputs = [ pkgs.glibc pkgs.libgit2 pkgs.zlib pkgs.openssl ];

    meta = with pkgs.lib; {
      description = "Helix text editor (nightly version)";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };

in

{
  programs.helix = with pkgs; {
    package = helix-nightly;
    enable = true;
    defaultEditor = true;
    extraPackages = [
      helix-nightly
      bash-language-server
      biome
      clang-tools
      helix-gpt
      marksman
      nil
      nixd
      nixpkgs-fmt
      nodePackages.prettier
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

      keys =
        {
          normal = {
            H = ":buffer-previous";
            L = ":buffer-next";
            C-y = [
              ":sh rm -f /tmp/unique-file"
              ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
              ":insert-output echo '\x1b[?1049h' > /dev/tty"
              ":open %sh{cat /tmp/unique-file}"
              ":redraw"
            ];

            space = {
              "." = ":fmt";
            };
          };
          select = {
            tab = "extend_parent_node_end";
            S-tab = "extend_parent_node_start";
          };
        };
    };
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
        # Other language configurations...
      ];
    };
  };
}
