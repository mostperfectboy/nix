{ pkgs, ... }:
{

  programs.hyprland.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-extra
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "GeistMono"
        "NerdFontsSymbolsOnly"
        "VictorMono"
      ];
    })
    manrope
  ];

  services.upower.enable = true;
}
