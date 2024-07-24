{ pkgs, ... }:
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/applications.nix
  ];
  home = {
    packages = with pkgs; [
      kanshi
      wl-clipboard
      cliphist
      pavucontrol
      pamixer
      lxqt.lxqt-policykit
      xdg-utils
      firefox
      seahorse
      dconf
      grim
      slurp
    ];
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "16x16";
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "mpd" ];
        modules-right = [
          "temperature"
          "battery"
          "clock"
          "tray"
        ];
        "hyprland/window" = {
          max-length = 200;
          separate-outputs = true;
        };
      };
    };
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    style = builtins.readFile ./desktop/waybar/style.css;
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "catppuccin-frappe-maroon-cursors";
    package = pkgs.catppuccin-cursors.frappeMaroon;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
    style.catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "maroon";
      apply = true;
    };
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "maroon";
      size = "standard";
      tweaks = [ "normal" ];
    };
  };

  services.kanshi = {
    enable = true;
    profiles = {
      default = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            scale = 1.5;
          }
        ];
      };
      office = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            scale = 1.5;
            position = "1920,1080";
          }
          {
            criteria = "Samsung Electric Company C27F390 H4LR903256";
            mode = "1920x1080";
            position = "0,0";
          }
          {
            criteria = "Samsung Electric Company C27F390 H4ZT800578";
            mode = "1920x1080";
            position = "1920,0";
          }

        ];
      };
      home = {
        outputs = [
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
      };
    };
  };
  services.mako = {
    enable = true;
    borderRadius = 4;
    extraConfig = ''
      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
