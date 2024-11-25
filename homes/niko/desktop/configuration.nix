{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    file-roller.enable = true;
    dconf.enable = true;
  };

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

  services.gvfs.enable = true;

  services.upower.enable = true;
}
