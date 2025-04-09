{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  cfg = config.modules.wezterm;
  toLua = x:
    if
      builtins.match ''
        .*
        .*''
      x
      != null
    then outputs.lib.trim x
    else "'${x}'";
in
  outputs.lib.mkDesktopModule' config "wezterm" (with outputs.lib; {
    package = mkOption {
      type = types.package;
      default = inputs.wezterm.packages.${system}.default;
    };
    exec = mkOption {
      type = types.functionTo types.str;
      default = cmd: let
        command =
          if builtins.isString cmd
          then outputs.lib.splitString " " cmd
          else cmd;
      in
        cfg.exec' {
          inherit command;
        };
    };
    # TODO Make a generic way that to connect the terminal to socket,
    # shouldn't crash if the exec' function doesn't support it.
    # Maybe exec'.extraOptions.socket=unix
    exec' = mkOption {
      type = types.functionTo types.str;
      default = {
        class ? null,
        command ? [],
      }: let
        cmd = ["start" "--"] ++ command;
        args =
          if class == null
          then "${builtins.concatStringsSep " " cmd}"
          else "${builtins.head cmd} --class=${class} ${
            builtins.concatStringsSep " " (builtins.tail cmd)
          }";
      in "${getExe config.programs.wezterm.package} ${args}";
      readOnly = true;
    };
    # TODO Does this belong under somewhere else?
    bitmap = mkOption {
      type = types.bool;
      default = false;
    };
    fonts = mkOption {
      type = types.listOf types.str;
      default = let
        bitmap = [
          # TODO Use fonts from packages directly
          "scientifica"
          "CozetteHiDpi"
          "TamzenForPowerline"
          "Unifont"
          "Unifont Upper"
        ];
        vector = [
          ''
            {
              family = 'JetBrains Mono',
              weight = 'Medium',
              harfbuzz_features = { 'calt', 'clig', 'liga', 'ss20', 'cv02', 'cv03', 'cv04', 'cv05', 'cv06', 'cv07', 'cv11', 'cv14', 'cv15', 'cv16', 'cv17' },
            }
          ''
          "JetBrainsMono Nerd Font"
        ];
      in
        (
          if cfg.bitmap
          then bitmap
          else vector
        )
        ++ ["CaskaydiaCove NFM"];
    };
  }) rec {
    home.shellAliases.ssh =
      outputs.lib.mkIf (config.defaultTerminal == "wezterm")
      "TERM=xterm-256color ssh";

    programs.nushell.shellAliases = {
      inherit (home.shellAliases) ssh;
    };

    nixos = {
      environment.systemPackages = with pkgs; [egl-wayland];
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [egl-wayland];
      };
    };

    home.packages = [cfg.package];
    programs.wezterm = {
      enable = true;
      package = cfg.package;
      # https://wezfurlong.org/wezterm/config/lua/config/index.html
      # FIXME Pane navigation doesn't work correctly
      extraConfig = let
        tab = ''
          { 'index', padding = { left = 1, right = 0, }, },
          'process',
        '';
      in ''
        local wezterm = require 'wezterm'
        local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
        local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
        local config = wezterm.config_builder()

        tabline.setup({
          options = {
            icons_enabled = false,
            theme = 'Ayu Dark (Gogh)',
            section_separators = {
              left = wezterm.nerdfonts.ple_right_half_circle_thick,
              right = wezterm.nerdfonts.ple_left_half_circle_thick,
            },
            component_separators = {
              left = wezterm.nerdfonts.ple_right_half_circle_thin,
              right = wezterm.nerdfonts.ple_left_half_circle_thin,
            },
            tab_separators = {
              left = wezterm.nerdfonts.ple_right_half_circle_thick,
              right = wezterm.nerdfonts.ple_left_half_circle_thick,
            },
          },
          sections = {
            tabline_a = { 'hostname' },
            tabline_b = { },
            tabline_c = { ' ' },
            tab_active = {
              ${tab}
              'zoomed',
            },
            tab_inactive = {
              ${tab}
            },
            tabline_x = { 'battery' },
            tabline_y = { 'datetime' },
            tabline_z = { },
          },
          extensions = { },
        })

        tabline.apply_to_config(config)

        smart_splits.apply_to_config(config, {
          direction_keys = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
          modifiers = {
            move = 'SHIFT',
            resize = 'SHIFT|ALT',
          },
        })

        -- config.color_scheme = 'Ayu Dark (Gogh)'
        -- config.colors = {
        --   background = 'none',
        -- }
        config.font = wezterm.font_with_fallback({
          ${
          builtins.concatStringsSep ",\n  "
          (map toLua cfg.fonts)
        }
        })
        config.font_size = 14.0
        config.warn_about_missing_glyphs = false
        config.default_cursor_style = "SteadyBar"
        config.window_decorations = "NONE"
        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }

        -- config.tab_bar_at_bottom = true
        -- config.hide_tab_bar_if_only_one_tab = true
        -- config.use_fancy_tab_bar = false
        -- config.show_new_tab_button_in_tab_bar = false
        -- config.alternate_buffer_wheel_scroll_speed = 1

        config.check_for_updates = false

        config.set_environment_variables = {
          TERMINFO_DIRS = '${config.home.profileDirectory}/share/terminfo',
          WSLENV = 'TERMINFO_DIRS',
          -- PATH = "${config.home.profileDirectory}/bin:''${PATH}"
        }
        config.term = 'wezterm'

        config.unix_domains = {
          {
            name = 'scratchpad',
          },
        }
        config.launch_menu = {
          {
            args = { 'btop', },
          },
          {
            label = 'Scratchpad',
            domain = { DomainName = 'scratchpad', },
          },
        }

        config.tiling_desktop_environments = {
          'X11 LG3D',
          'X11 bspwm',
          'X11 i3',
          'X11 dwm',
          'Wayland',
        }

        config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
        config.keys = {
          {
            key = 'z',
            mods = 'LEADER',
            action = wezterm.action.TogglePaneZoomState,
          },
          {
            key = '|',
            mods = 'LEADER',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
          },
          {
            key = '-',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
          },
          {
            key = 'd',
            mods = 'LEADER',
            action = wezterm.action.DetachDomain('CurrentPaneDomain'),
          },
          {
            key = 'LeftArrow',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateTabRelative(-1),
          },
          {
            key = 'RightArrow',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateTabRelative(1),
          },
          {
            key = 'c',
            mods = 'ALT',
            action = wezterm.action.CopyTo("Clipboard"),
          },
          {
            key = 'v',
            mods = 'ALT',
            action = wezterm.action.PasteFrom("Clipboard"),
          },
          {
            key = 'LeftArrow',
            mods = 'SHIFT',
            action = wezterm.action.ActivatePaneDirection("Left"),
          },
          {
            key = 'RightArrow',
            mods = 'SHIFT',
            action = wezterm.action.ActivatePaneDirection("Right"),
          },
          {
            key = 'UpArrow',
            mods = 'SHIFT',
            action = wezterm.action.ActivatePaneDirection("Up"),
          },
          {
            key = 'DownArrow',
            mods = 'SHIFT',
            action = wezterm.action.ActivatePaneDirection("Down"),
          },
          {
            key = 'LeftArrow',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize { 'Left', 5 },
          },
          {
            key = 'RightArrow',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize { 'Right', 5 },
          },
          {
            key = 'UpArrow',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize { 'Up', 5 },
          },
          {
            key = 'DownArrow',
            mods = 'SHIFT|ALT',
            action = wezterm.action.AdjustPaneSize { 'Down', 5 },
          },
          {
            key = 'T',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnCommandInNewTab { cwd = wezterm.home_dir },
          }
        }

        return config
      '';
    };
  }
