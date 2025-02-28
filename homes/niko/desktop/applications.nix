{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.obs-move-transition
      obs-studio-plugins.obs-tuna
      obs-studio-plugins.input-overlay
    ];
  };
  home.packages = with pkgs; [ 
    spotify
    nautilus
   ];
}
