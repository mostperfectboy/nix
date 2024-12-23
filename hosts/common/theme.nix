{ pkgs, ... }:
{
  imports = [ ../../pkgs/catppuccin.nix ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-extra
    font-awesome
    geist-font
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.geist-mono
    nerd-fonts.symbols-only
    nerd-fonts.victor-mono
    manrope
  ];
}
