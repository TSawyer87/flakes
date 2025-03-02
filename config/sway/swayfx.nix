{ ... }: {
  # SceneFX configuration
  wayland.windowManager.sway = {

    extraConfig = ''
      ### Appearance
      # window corner radius in px
      corner_radius 6

      # Window background blur
      blur enable
      blur_xray off
      blur_passes 2
      blur_radius 2

      # Shadows
      shadows enable
      shadows_on_csd off
      shadow_blur_radius 8
      shadow_color #0000007F

      # Waybar blur
      layer_effects "waybar" blur enable; shadows enable; corner_radius 10

      # Inactive window dimming
      default_dim_inactive 0.2
      dim_inactive_colors.unfocused #000000FF
      dim_inactive_colors.urgent #900000FF

      # Move minimized windows into Scratchpad (enable|disable)
      # scratchpad_minimize disable
    '';
  };
}
