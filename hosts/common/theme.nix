{ pkgs, ... }:
{
  imports = [ ../../pkgs/stylix.nix ];

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

  stylix.targets.gtk.enable = false;

}
