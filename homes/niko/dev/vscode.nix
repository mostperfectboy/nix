{ pkgs, ... }:
{
  nixpkgs.overlays = [ (import ./vscode/fontOverlay.nix) ];
  home.packages = with pkgs; [
    vscode
    zed-editor
  ];
  home.file.".config/code-flags.conf" = {
    text = ''
      --gtk-version=4
      --enable-features=TouchpadOverscrollHistoryNavigation
      --enable-wayland-ime
      --password-store=gnome-libsecret
    '';
    force = true;
  };
}
