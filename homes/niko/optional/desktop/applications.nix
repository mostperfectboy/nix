{ pkgs, ... }:
{
  home.packages = with pkgs; [
    spotify
    nautilus
    file-roller
  ];
}
