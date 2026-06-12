{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.niri.homeModules.config ];

  home.packages = [
    config.programs.niri.package
    pkgs.xwayland-satellite
  ];

  programs.niri.settings = {
    input = {
      keyboard.xkb = {
        layout = "us";
        options = "compose:ralt";
      };

      touchpad.natural-scroll = true;

      mouse = {
        accel-profile = "flat";
        accel-speed = 0.0;
      };
    };

    layout = {
      gaps = 6;

      struts = {
        left = 6;
        right = 6;
        top = 6;
        bottom = 6;
      };

      default-column-width.proportion = 0.66667;

      border.enable = false;

      shadow = {
        enable = true;
        softness = 30;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
        color = "rgba(0, 0, 0, 0.45)";
      };
    };

    layer-rules = [
      {
        matches = [{ namespace = "^noctalia-overview*"; }];
        place-within-backdrop = true;
      }
    ];

    prefer-no-csd = true;

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
        clip-to-geometry = true;
        default-column-width.proportion = 0.66667;
        open-maximized = false;
      }
      {
        matches = [
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      "Mod+R".action.spawn = [ "ghostty" ];
      "Mod+E".action.spawn = [ "thunar" ];
      "Mod+Space".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "Mod+V".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "clipboard"
      ];
      "Mod+L".action.spawn = [
        "noctalia"
        "msg"
        "session"
        "lock"
      ];

      "Mod+Q" = {
        repeat = false;
        action.close-window = [ ];
      };
      "Mod+F".action.maximize-column = [ ];

      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Down".action.focus-window-down = [ ];
      "Mod+Up".action.focus-window-up = [ ];
      "Mod+Right".action.focus-column-right = [ ];

      "Mod+Ctrl+Left".action.move-column-left = [ ];
      "Mod+Ctrl+Down".action.move-window-down = [ ];
      "Mod+Ctrl+Up".action.move-window-up = [ ];
      "Mod+Ctrl+Right".action.move-column-right = [ ];

      "Mod+Tab".action.focus-workspace-down = [ ];
      "Alt+Tab".action.focus-workspace-down = [ ];
      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action.focus-workspace-down = [ ];
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action.focus-workspace-up = [ ];
      };

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = [
          "pamixer"
          "--toggle-mute"
        ];
      };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "pamixer"
          "-i"
          "5"
        ];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "pamixer"
          "-d"
          "5"
        ];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [
          "brightnessctl"
          "set"
          "+5%"
        ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];
      };

      "Mod+Shift+S".action.spawn = [
        "hyprshot"
        "-m"
        "region"
        "--clipboard-only"
      ];
      "Ctrl+Print".action.screenshot-screen = [ ];
      "Alt+Print".action.screenshot-window = [ ];

      "Mod+Shift+E".action.quit = [ ];
    };
  };
}
