{ ... }: {
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
    style = builtins.readFile ./waybar/style.css;
  };
}