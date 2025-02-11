{ pkgs, lib, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "lua"
      "basher"
    ];

    ## everything inside of these brackets are Zed options.
    userSettings = {
      vim_mode = true;
      inactive_opacity = "0.5";
      auto_install_extensions = true;

      assistant = {
        enabled = false;
        version = "2";
        default_open_ai_model = null;
        ### PROVIDER OPTIONS
        ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
        ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
        ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };

        #                inline_alternatives = [
        #                    {
        #                        provider = "copilot_chat";
        #                        model = "gpt-3.5-turbo";
        #                    }
        #                ];
      };

      node = {
        path = lib.getExe pkgs.nodejs_22;
        npm_path = lib.getExe' pkgs.nodejs_22 "npm";
      };

      hour_format = "hour12";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "ghostty";
        };
        font_family = "JetBrains Mono Nerd Font Mono";
        font_features = null;
        font_size = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        #{
        #                    program = "zsh";
        #};
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };

        rust-analyzer = {
          binary = {
            path = "/nix/store/lxc7w9pr0d83mi2ij82g27ydpz9kzcbh-rust-default-1.86.0-nightly-2025-02-04/bin/rust-analyzer";
          };
          # Settings for rust-analyzer
          settings = {
            diagnostics = {
              enable = true;
              styleLints.enable = true;
            };

            checkOnSave = true;
            check = {
              command = "clippy";
              features = "all";
            };

            cargo = {
              buildScripts.enable = true;
              features = "all";
            };

            # Additional settings you might want to configure
            inlayHints = {
              bindingModeHints.enable = true;
              closureStyle = "rust_analyzer";
              closureReturnTypeHints.enable = "always";
              discriminantHints.enable = "always";
              expressionAdjustmentHints.enable = "always";
              implicitDrops.enable = true;
              lifetimeElisionHints.enable = "always";
              rangeExclusiveHints.enable = true;
            };

            procMacro = {
              enable = true;
            };

            rustc = {
              source = "discover";
            };

            files = {
              excludeDirs = [
                ".cargo"
                ".direnv"
                ".git"
                "node_modules"
                "target"
              ];
            };
          };
        };

        # Your existing LSP settings for other languages
        settings = {
          dialyzerEnabled = true;
        };
      };
    };
    userKeymaps = [
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual)";
        bindings = {
          "space g h d" = "editor::ToggleHunkDiff";
          "space g h r" = "editor::RevertSelectedHunks";
          # Toggle inlay hints
          "space t i" = "editor::ToggleInlayHints";
          # Toggle soft wrap
          "space u w" = "editor::ToggleSoftWrap";
          # Toggle Zen Mode
          "space c z" = "workspace::ToggleCenteredLayout";

        };
      }
    ];
  };
}
