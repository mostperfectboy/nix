{ ... }:
let
  wallpaper = builtins.fetchurl {
    url = "https://i.imgur.com/qHwLQaz.png";
    sha256 = "02598d624621090070beaced6cc3bcb9809c137505d5e81141c749bddaa92981";
  };
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaper
      ];
      wallpaper = {
        path = wallpaper;
        monitor = "";
      };
    };
  };
}
