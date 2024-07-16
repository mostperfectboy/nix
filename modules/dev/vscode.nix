{ pkgs, ... }:
{
  nixpkgs.overlays = [ (import ./vscode/fontOverlay.nix) ];

  home.packages = with pkgs; [ vscode ];
}
