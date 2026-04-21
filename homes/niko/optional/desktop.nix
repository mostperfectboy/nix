# Desktop environment (Hyprland, Waybar, etc)
{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./desktop/hyprland.nix
    ./desktop/applications.nix
  ];

  home = {
    packages = with pkgs; [
      pavucontrol
      pamixer
      lxqt.lxqt-policykit
      wl-clipboard
      xdg-utils
      firefox
      pywalfox-native
      seahorse
      dconf
      hyprshot
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      playerctl
      sptlrx
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
  };

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [ "Geist" ];
      serif = [ "Geist" ];
      monospace = [ "VictorMono NF SemiBold" ];
      emoji = [ "Noto Color Emoji" ];
    };
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      appLauncher = {
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        density = "compact";
        enableClipboardHistory = true;
        terminalCommand = "ghostty -e";
      };

      bar = {
        density = "comfortable";
        widgets = {
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm - dd MM";
              tooltipFormat = "HH:mm ddd, MMM dd";
            }
          ];
          left = [
            {
              id = "Workspace";
              characterCount = 2;
              labelMode = "index";
              showLabelsOnlyWhenOccupied = true;
            }
            {
              id = "ActiveWindow";
              hideMode = "hidden";
              maxWidth = 240;
              scrollingMode = "hover";
              showIcon = true;
              showText = true;
              useFixedWidth = true;
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 145;
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = true;
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              diskPath = "/";
              showCpuTemp = true;
              showCpuUsage = true;
              showMemoryUsage = true;
              useMonospaceFont = true;
              usePadding = false;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              id = "Battery";
              displayMode = "icon-always";
              hideIfIdle = true;
              hideIfNotDetected = true;
            }
            {
              id = "Volume";
              displayMode = "alwaysHide";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              id = "ControlCenter";
              icon = "noctalia";
              useDistroLogo = true;
            }
          ];
        };
      };

      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };

      dock = {
        backgroundOpacity = 0.66;
        groupApps = true;
        showLauncherIcon = true;
      };

      general = {
        avatarImage = "${config.home.homeDirectory}/.face";
        forceBlackScreenCorners = true;
        lockScreenBlur = 0.16;
        lockScreenTint = 0.15;
        passwordChars = true;
        showScreenCorners = true;
      };

      idle = {
        enabled = true;
        customCommands = [
          {
            name = "Dim";
            timeout = 180;
            command = "brightnessctl -s set 25%";
            resumeCommand = "brightnessctl -r";
          }
          {
            name = "Suspend";
            timeout = 1000;
            command = "[ \"$(cat /sys/class/power_supply/AC/online 2>/dev/null)\" = \"0\" ] && noctalia-shell ipc call sessionMenu lockAndSuspend";
            resumeCommand = "";
          }
        ];
      };

      location = {
        autoLocate = false;
        name = "Bochum";
      };

      osd = {
        location = "bottom";
      };

      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "ghostty";
          }
          {
            enabled = true;
            id = "hyprland";
          }
          {
            enabled = true;
            id = "zed";
          }
          {
            enabled = true;
            id = "pywalfox";
          }
          {
            enabled = true;
            id = "zenBrowser";
          }
          {
            enabled = true;
            id = "code";
          }
        ];
        enableUserTheming = true;
      };

      ui = {
        fontDefault = "VictorMono NF";
        fontFixed = "monospace";
        settingsPanelMode = "window";
      };
    };
  };

  services = {
    kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      settings = [
        {
          output.criteria = "eDP-1";
          output.scale = 1.5;
        }
        {
          profile.name = "default";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        }
        {
          profile.name = "office";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
              mode = "1920x1200";
              scale = 1.5;
              position = "1920,1080";
            }
            {
              criteria = "Samsung Electric Company C27F390 H4ZT800705";
              mode = "1920x1080";
              position = "0,0";
            }
            {
              criteria = "Samsung Electric Company C27F390 H4ZT800351";
              mode = "1920x1080";
              position = "1920,0";
            }
          ];
        }
        {
          profile.name = "docked";
          profile.outputs = [
            {
              criteria = "DP-8";
              mode = "2560x1440";
              position = "2360,480";
              scale = 1.25;
            }
            {
              criteria = "eDP-1";
              mode = "1920x1200";
              scale = 1.5;
              position = "0,1280";
            }
            {
              criteria = "DP-11";
              mode = "1920x1080@60";
              position = "1280,0";
              transform = "90";
            }
          ];
        }
        {
          profile = {
            name = "home";
            outputs = [
              {
                criteria = "DP-1";
                mode = "2560x1440";
                position = "1080,480";
                scale = 1.25;
              }
              {
                criteria = "HDMI-A-1";
                mode = "1920x1080";
                position = "3124,800";
              }
              {
                criteria = "DP-2";
                mode = "1920x1080@60";
                position = "0,0";
                transform = "90";
              }
            ];
          };
        }
      ];
    };
    cliphist = {
      enable = true;
    };
  };
}
