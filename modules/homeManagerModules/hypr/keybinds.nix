{ host, username, config, ... }:
let
  inherit (import ../../../hosts/${host}/variables.nix)
    browser terminal extraMonitorSettings keyboardLayout;
  # submap = resize;
in {
  wayland.windowManager.hyprland = {
    settings = {

      bind = [
        "$modifier,Return,exec,${terminal}"
        "$modifier,T,exec,kitty"
        # "CONTROL,SPACE,exec,rofi-launcher"
        "$modifier SHIFT,W,exec,web-search"
        "$modifier ALT,W,exec,killall -9 wpaperd && wpaperd"
        "$modifier SHIFT,N,exec,swaync-client -rs"
        "$modifier SHIFT,N,exec,swaync-client -rs"
        "$modifier,W,exec,${browser}"
        "$modifier,F,exec,firefox"
        "$modifier,V,exec,cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$modifier,E,exec,emopicker9000"
        "$modifier,S,exec,screenshootin"
        "$modifier,D,exec,pkill wofi || wofi --normal-window --show drun --allow-images"
        "$modifier,O,exec,obs"
        "$modifier,C,exec,hyprpicker -a"
        "$modifier,G,exec,gimp"
        "$modifier SHIFT,Return, exec,pypr toggle term"
        "$modifier SHIFT,T,exec,pypr toggle thunar"
        "CONTROL ALT, Delete, exec, wlogout"
        "$modifier,M,exec,pavucontrol"
        "$modifier,Q,killactive,"
        "$modifier,P,exec,pypr toggle volume"
        "$modifier SHIFT,P,pseudo,"
        "$modifier SHIFT,I,togglesplit,"
        "ALT,Return,fullscreen,"
        "$modifier SHIFT,F,togglefloating,"
        "$modifier SHIFT,C,exit,"
        "$modifier SHIFT,left,movewindow,l"
        "$modifier SHIFT,right,movewindow,r"
        "$modifier SHIFT,up,movewindow,u"
        "$modifier SHIFT,down,movewindow,d"
        "$modifier SHIFT,h,movewindow,l"
        "$modifier SHIFT,l,movewindow,r"
        "$modifier SHIFT,k,movewindow,u"
        "$modifier SHIFT,j,movewindow,d"
        "$modifier ALT, left, swapwindow,l"
        "$modifier ALT, right, swapwindow,r"
        "$modifier ALT, up, swapwindow,u"
        "$modifier ALT, down, swapwindow,d"
        "$modifier ALT, 43, swapwindow,l"
        "$modifier ALT, 46, swapwindow,r"
        "$modifier ALT, 45, swapwindow,u"
        "$modifier ALT, 44, swapwindow,d"
        "$modifier,left,movefocus,l"
        "$modifier,right,movefocus,r"
        "$modifier,up,movefocus,u"
        "$modifier,down,movefocus,d"
        "$modifier,h,movefocus,l"
        "$modifier,l,movefocus,r"
        "$modifier,k,movefocus,u"
        "$modifier,j,movefocus,d"
        "$modifier,0,workspace,10"
        "$modifier SHIFT,SPACE,movetoworkspace,special"
        "$modifier,SPACE,togglespecialworkspace"
        "$modifier SHIFT,0,movetoworkspace,10"
        "$modifier CONTROL,right,workspace,e+1"
        "$modifier CONTROL,left,workspace,e-1"
        "$modifier,mouse_down,workspace, e+1"
        "$modifier,mouse_up,workspace, e-1"
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
        # "$modifier,R,submap,resize"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$modifier, code:1${toString i}, workspace, ${toString ws}"
            "$modifier SHIFT, code:1${toString i}, movetoworkspace, ${
              toString ws
            }"
          ]) 9)) ++ (
            # workspaces
            # binds $mod + {1..9} to [to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$modifier, code:1${toString i}, workspace, ${toString ws}"
                "$modifier, code:1${toString i}, workspace, ${toString ws}"
              ]) 9));
      # binde = [
      #   # "submap=resize"
      #   ",right,resizeactive,50 0"
      #   ",L,resizeactive,50 0"
      #   ",left,resizeactive,-50 0"
      #   ",H,resizeactive,-50 0"
      #   ",up,resizeactive,0 -50"
      #   ",K,resizeactive,0 -50"
      #   ",down,resizeactive,0 50"
      #   ",J,resizeactive,0 50"
      #   "submap=reset"
      # ];

      bindm = [
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];

    };

    # extraConfig =
    #   "\n      monitor=,preferred,auto,auto\n      monitor=DP-1, 3840x2160, 0x0, 1.5\n      ${extraMonitorSettings}\n    ";
  };
}

