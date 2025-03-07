-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- This is where you actually apply your config choices
-- Font Settings
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Symbola",
})
config.font_size = 12
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = false
config.use_dead_keys = false
config.enable_scroll_bar = true
config.window_background_opacity = 0.80
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
-- config.default_prog = { "/usr/bin/zsh", "-l" }
-- For example, changing the color scheme:
config.color_scheme = "Dracula"
config.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }
-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.8,
}

config.leader = { key = "a", mods = "CTRL", timeout_miliseconds = 1000 }
config.keys = {
  -- send C-a when pressing C-a twice
  { key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
  -- Pane keybinds
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- shift is for when caps lock is on
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "s", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  -- You can make separate keybindings for resizing panes
  -- but wezterm offers custom "mode" in the name of "KeyTable"
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
  },
  -- Tab keybindings
  { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
  -- Key table for moving tabs around
  {
    key = "m",
    mods = "LEADER",
    action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }),
  },
  -- Lastly, workspace
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}
--
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end
config.key_tables = {
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
}
-- Tab Bar
config.use_fancy_tab_bar = true
config.status_update_interval = 1000
wezterm.on("update-right-status", function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
  end
  if window:leader_is_active() then
    stat = "LDR"
  end

  -- Current working directory
  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end
  local cwd = basename(pane:get_current_working_dir())
  -- Current command
  local cmd = basename(pane:get_foreground_process_name())

  -- Time
  local time = wezterm.strftime("%H:%M")
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Foreground = { Color = "FFB86C" } },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = " |" },
  }))
end)
-- Move tab bar to the bottom
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
-- bar
bar.apply_to_config(config, { enabled_modules = { hostname = false } })
-- Apply the configuration to WezTerm
return config
