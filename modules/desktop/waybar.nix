{ pkgs, ... }: 
let

  mediaplayer-script = pkgs.writeTextFile {
    name = "mediaplayer.sh";
    text = builtins.readFile ./waybar/mediaplayer.sh;
    executable = true;
  };
in
{
  home.packages = with pkgs; [ playerctl ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "custom/media" ];
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
        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 60;
          format-icons = {
            "spotify"= "";
            "default"= "🎜";
          };
          escape = true;
          exec = "${mediaplayer-script} 2> /dev/null";
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