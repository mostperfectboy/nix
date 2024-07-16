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
    noto-fonts-cjk
    noto-fonts-extra
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "GeistMono"
        "NerdFontsSymbolsOnly"
      ];
    })
    manrope
  ];

  fonts.fontconfig.defaultFonts = {
    "sansSerif" = [ "GeistMono NF" ];
    "serif" = [ "GeistMono NF" ];
    "monospace" = [ "GeistMono NF" ];
  };

  security.polkit.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gvfs.enable = true;
}
