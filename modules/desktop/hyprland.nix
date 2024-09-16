{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hypr/hyprland.conf);
    systemd = {
      enable = true;
    };
    xwayland.enable = true;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    FLAKE = /home/niko/nix/;
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = (builtins.readFile ./hypr/hyprlock.conf);
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 30000;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
    hyprpaper = {
      enable = true;
      settings = {
        preload = "~/Wallpapers/frappe_poly_mountain.jpg";
        wallpaper = [ ",~/Wallpapers/frappe_poly_mountain.jpg" ];
      };
    };
  };
}
