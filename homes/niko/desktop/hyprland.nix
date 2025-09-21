{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      "$terminal" = "ghostty";
      "$fileManager" = "thunar";
      "$menu" = "rofi";
      "$mainMod" = "SUPER";
      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
        follow_mouse = 2;
        touchpad = {
          natural_scroll = "yes";
        };
        accel_profile = "flat";
        sensitivity = 0;
      };
      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(f0c6c6ff)";
        "col.inactive_border" = "rgba(cad3f5ff)";
        layout = "dwindle";
        allow_tearing = false;
      };
      decoration = {
        rounding = 6;
        active_opacity = 0.95;
        inactive_opacity = 0.85;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = true;
          contrast = 0.2;
        };
      };
      animations = {
        enabled = "yes";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master = {
        new_status = "master";
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
        focus_on_activate = true;
      };
      windowrulev2 = [
        "float,class:^(Rofi)$"
        "suppressevent maximize, class:.*"
      ];
      bind = [
        "$mainMod, R, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, exec, cliphist list | $menu -dmenu | cliphist decode | wl-copy"
        "$mainMod, F, togglefloating"
        "$mainMod, space, exec, $menu -show drun"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, L, exec, hyprlock"
        "$mainModShift, S, exec, hyprshot -m region --clipboard-only"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, TAB, workspace, m+1"
        "alt, tab, workspace, m+1"
        ",XF86AudioMute,exec,pamixer --toggle-mute"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mainMod, code:1${toString i}, workspace, ${toString ws}"
            "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      layerrule = [
        "blur, waybar"
        "blur, rofi"
      ];
    };
  };
  imports = [ ./hypr/hyprpaper.nix ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    NH_FLAKE = /home/niko/nix;
  };

  programs.hyprlock = {
    enable = true;
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
        };
        listener = [
          {
            timeout = 60;
            on-timeout = "brightnessctl -s set 10%";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 360;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1200;
            on-timeout = "[ $(cat /sys/class/power_supply/AC/online) -eq 0 ] && systemctl suspend";
          }
        ];
      };
    };
  };
}
