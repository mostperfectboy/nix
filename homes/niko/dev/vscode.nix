{ ... }:
{
  nixpkgs.overlays = [ (import ./vscode/fontOverlay.nix) ];
  programs.vscode = {
    enable = true;
  };
}