{
  system,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${system}.default;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

      return {
        font = wezterm.font("JetBrains Mono"),
        font_size = 12.0,
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = true,
        tab_bar_at_bottom = true,
        window_close_confirmation = "NeverPrompt",

        leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

        keys = {
          { key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
          { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
          { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
          { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
          { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
          { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
          { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
          { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
          { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
          { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
          { key = "s", mods = "LEADER", action = act.RotatePanes("Clockwise") },
          { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
          { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
          { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
          { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
          { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
          { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
          { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
        },

        key_tables = {
          resize_pane = {
            { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
            { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
            { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
            { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
            { key = "Escape", action = "PopKeyTable" },
            { key = "Enter", action = "PopKeyTable" },
          },

          move_tab = {
            { key = "h", action = act.MoveTabRelative(-1) },
            { key = "j", action = act.MoveTabRelative(-1) },
            { key = "k", action = act.MoveTabRelative(1) },
            { key = "l", action = act.MoveTabRelative(1) },
            { key = "Escape", action = "PopKeyTable" },
            { key = "Enter", action = "PopKeyTable" },
          },
        },
      }
    '';
  };
}
