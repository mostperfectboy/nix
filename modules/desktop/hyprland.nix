{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hypr/hyprland.conf);
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    FLAKE = /home/niko/nix;
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = (builtins.readFile ./hypr/hyprlock.conf);
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

  };
}
