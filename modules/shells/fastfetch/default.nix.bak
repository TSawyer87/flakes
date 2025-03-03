# { config, pkgs, ... }:
# let
#   randomPng = pkgs.runCommand "random-png" {} ''
#     mkdir -p $out
#     ln -s $(find "/home/jr/.config/fastfetch/pngs/" -name "*.png" | shuf -n 1) $out/random.png
#   '';
# in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        color = {
          keys = "35";
          output = "90";
        };
      };

      logo = {
        source = "./pngs/ryuzaki.png";
        type = "kitty-direct";
        height = 15;
        width = 30;
        padding = {
          top = 3;
          left = 3;
        };
      };

      modules = [
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "cpu";
          key = "│  ";
        }
        {
          type = "gpu";
          key = "│ 󰍛 ";
        }
        {
          type = "memory";
          key = "│ 󰑭 ";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "custom";
          format = " OS -> NixOS 25.05 (Warbler) ";
        }
        {
          type = "kernel";
          key = "│ ├ ";
        }
        {
          type = "packages";
          key = "│ ├󰏖 ";
        }
        {
          type = "shell";
          key = "└ └ ";
        }
        "break"
        {
          type = "wm";
          key = "  󱗃 WM";
          format = "{2}";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼 ";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
        }
        {
          type = "terminal";
          key = "└ └ ";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌────────────────────Uptime / Age────────────────────┐";
        }
        {
          type = "command";
          key = "│  ";
          text = # bash
            ''
              birth_install=$(stat -c %W /)
              current=$(date +%s)
              delta=$((current - birth_install))
              delta_days=$((delta / 86400))
              echo $delta_days days
            '';
        }
        {
          type = "uptime";
          key = "│  ";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
