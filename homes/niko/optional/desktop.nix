# Desktop environment (Hyprland, Waybar, etc)
{
  pkgs,
  inputs,
  system,
  ...
}:
let
  sptlrx-script = pkgs.writeTextFile {
    name = "sptlrx.sh";
    text = builtins.readFile ./desktop/waybar/sptlrx.sh;
    executable = true;
  };
in
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/applications.nix
    ../../../pkgs/catppuccin.nix
  ];

  home = {
    packages = with pkgs; [
      pavucontrol
      pamixer
      lxqt.lxqt-policykit
      wl-clipboard
      xdg-utils
      firefox
      seahorse
      dconf
      hyprshot
      inputs.zen-browser.packages."${system}".default
      playerctl
      sptlrx
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
    file = {
      ".zen/7wwpradk.default/chrome/userChrome.css" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/zen-browser/b048e8bd54f784d004812036fb83e725a7454ab4/themes/Macchiato/Rosewater/userChrome.css";
          sha256 = "sha256-nLCa0VvsOnlb82cZyVIWapIiGNPETUprdnaIhhU45PU=";
        };
      };
      ".zen/7wwpradk.default/chrome/userContent.css" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/zen-browser/b048e8bd54f784d004812036fb83e725a7454ab4/themes/Macchiato/Rosewater/userContent.css";
          sha256 = "sha256-I26WMP1a0oskSJgwh5WGz4BqBv2yJm1beLXiFCGXWLY=";
        };
      };
      ".zen/7wwpradk.default/chrome/zen-logo-macchiato.svg" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/zen-browser/b048e8bd54f784d004812036fb83e725a7454ab4/themes/Macchiato/Rosewater/zen-logo-macchiato.svg";
          sha256 = "sha256-r+XfE2KK9CgosgI31GusRGCkSZ8pupuHYcVUl6X01Mk=";
        };
      };
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

  programs.rofi = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: Symbols Nerd Font, monospace;
        font-weight: 700;
      }


      #custom-lyrics {
        padding: 0 10px;
        color: #89b4fa;
        font-weight: bold;
      }

      #custom-lyrics.lyrics-playing {
        color: #a6e3a1;
      }

      #custom-lyrics.lyrics-paused {
        color: #f9e2af;
      }

      window#waybar {
        background: transparent;
      }

      #network,
      #temperature,
      #battery,
      #clock,
      #workspaces {
        background: @base;
        border-radius: 12px;
        padding: 4px 12px;
        margin: 6px 6px;
        color: @text;
      }

      #workspaces button {
        color: @overlay0;
        border-radius: 8px;
        background: transparent;
        padding: 0 4px;
        margin: 0 2px;
      }

      #workspaces button.active {
        color: @text;
        background: @surface0;
      }

      #workspaces button:hover {
        background: @surface1;
        color: @text;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
        ];
        modules-center = [ "custom/lyrics" ];
        modules-right = [
          "network"
          "temperature"
          "battery"
          "clock"
        ];
        network = {
          format-wifi = "{essid}@{signalStrength}%";
          interval = 5;
          tooltip = true;
        };
        "custom/lyrics" = {
          format = "{}";
          return-type = "json";
          max-length = 80;
          escape = true;
          exec = "${sptlrx-script} 2> /dev/null";
        };
      };
    };
    systemd.enable = true;
  };

  catppuccin = {
    cursors.enable = false;
    gtk.icon.enable = false;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Colloid-Pink-Catppuccin";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "pink" ];
      };
    };
    theme = {
      name = "Catppuccin-GTK-Pink-Dark-Macchiato";
      package = pkgs.magnetic-catppuccin-gtk.override {
        shade = "dark";
        accent = [ "pink" ];
        tweaks = [ "macchiato" ];
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
    mako = {
      enable = true;
      settings = {
        "mode=do-not-disturb" = {
          invisible = true;
        };
        "app-name=Spotify" = {
          invisible = true;
        };
      };
    };
    cliphist = {
      enable = true;
    };
  };
}
