{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod,Return,exec,ghostty"
          "$mod,T,exec,kitty"
          # "CONTROL,SPACE,exec,rofi-launcher"
          "$mod SHIFT,W,exec,web-search"
          "$mod ALT,W,exec,killall -9 wpaperd && wpaperd"
          "$mod SHIFT,N,exec,swaync-client -rs"
          "$mod SHIFT,N,exec,swaync-client -rs"
          "$mod,W,exec,wezterm"
          "$mod,F,exec,firefox"
          "$mod,V,exec,cliphist list | wofi --dmenu | cliphist decode | wl-copy"
          "$mod,E,exec,emopicker9000"
          "$mod,S,exec,screenshootin"
          "$mod,D,exec,pkill wofi || wofi --normal-window --show drun --allow-images"
          # "$mod,O,exec,obs"
          "$mod,C,exec,hyprpicker -a"
          "$mod,G,exec,gimp"
          "$mod SHIFT,Return, exec,pypr toggle term"
          "$mod SHIFT,T,exec,pypr toggle thunar"
          "CONTROL ALT, Delete, exec, wlogout"
          "$mod,M,exec,pavucontrol"
          "$mod,Q,killactive,"
          "$mod,P,exec,pypr toggle volume"
          "$mod SHIFT,P,pseudo,"
          "$mod SHIFT,I,togglesplit,"
          "ALT,Return,fullscreen,"
          "$mod SHIFT,F,togglefloating,"
          "$mod SHIFT,C,exit,"
          "$mod SHIFT,left,movewindow,l"
          "$mod SHIFT,right,movewindow,r"
          "$mod SHIFT,up,movewindow,u"
          "$mod SHIFT,down,movewindow,d"
          "$mod SHIFT,h,movewindow,l"
          "$mod SHIFT,l,movewindow,r"
          "$mod SHIFT,k,movewindow,u"
          "$mod SHIFT,j,movewindow,d"
          "$mod ALT, left, swapwindow,l"
          "$mod ALT, right, swapwindow,r"
          "$mod ALT, up, swapwindow,u"
          "$mod ALT, down, swapwindow,d"
          "$mod ALT, 43, swapwindow,l"
          "$mod ALT, 46, swapwindow,r"
          "$mod ALT, 45, swapwindow,u"
          "$mod ALT, 44, swapwindow,d"
          "$mod,left,movefocus,l"
          "$mod,right,movefocus,r"
          "$mod,up,movefocus,u"
          "$mod,down,movefocus,d"
          "$mod,h,movefocus,l"
          "$mod,l,movefocus,r"
          "$mod,k,movefocus,u"
          "$mod,j,movefocus,d"
          "$mod,0,workspace,10"
          "$mod SHIFT,SPACE,movetoworkspace,special"
          "$mod,SPACE,togglespecialworkspace"
          "$mod SHIFT,0,movetoworkspace,10"
          "$mod CONTROL,right,workspace,e+1"
          "$mod CONTROL,left,workspace,e-1"
          "$mod,mouse_down,workspace, e+1"
          "$mod,mouse_up,workspace, e-1"
          "ALT,Tab,cyclenext"
          "ALT,Tab,bringactivetotop"
          ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
          # "$mod,R,submap,resize"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList
            (i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ])
            9)
        )
        ++ (
          # workspaces
          # binds $mod + {1..9} to [to] workspace {1..9}
          builtins.concatLists (builtins.genList
            (i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod, code:1${toString i}, workspace, ${toString ws}"
            ])
            9)
        );

      bindm = ["$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow"];
    };
  };
}
