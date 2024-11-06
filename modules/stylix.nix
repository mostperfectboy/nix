{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    autoEnable = true;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "GeistMono" ]; };
        name = "Geist Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
