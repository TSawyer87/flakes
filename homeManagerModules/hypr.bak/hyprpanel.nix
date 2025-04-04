# *.nix
{inputs, ...}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    # Enable the module.
    # Default: false
    enable = true;
    overlay.enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""
    # theme = "dracula";
    theme = "cyberpunk";
    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    override = {theme.bar.menus.text = "#123ABC";};

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "1" = {
          left = ["dashboard" "workspaces" "cpu" "ram"];
          middle = ["weather" "clock"];
          right = ["volume" "bluetooth" "systray" "notifications" "power"];
        };
        "0" = {
          left = ["dashboard" "workspaces" "cpu" "ram"];
          middle = ["weather" "clock"];
          right = ["volume" "bluetooth" "systray" "notifications" "power"];
        };
      };
    };

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.location = "Orlando";
        weather.unit = "imperial";
      };

      bar.customModules.weather.label = true;
      bar.customModules.weather.unit = "imperial";

      bar.clock.format = "%a %b %d  %I:%M %p";
      bar.clock.icon = "󰸗";
      bar.customModules.cpu.leftClick = "htop";
      menus.dashboard.directories.enabled = true;
      #menus.dashboard.stats.enable_gpu = true;
      menus.dashboard.shortcuts.left.shortcut1.tooltip = "Firefox";
      menus.dashboard.shortcuts.left.shortcut1.command = "firefox";
      menus.dashboard.shortcuts.left.shortcut1.icon = "🦊";
      menus.dashboard.shortcuts.left.shortcut2.tooltip = "Btop";
      menus.dashboard.shortcuts.left.shortcut2.command = "btop";
      menus.dashboard.shortcuts.left.shortcut2.icon = "📈";

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };
}
