{ ... }:
{
  nixpkgs.overlays = [ (import ./vscode/fontOverlay.nix) ];
  programs.vscode = {
    enable = true;
  };
  home.file.".vscode/argv.json" = {
    text = builtins.toJSON {
    enable-crash-reporter = false;
    password-store = "gnome";
  };
    force = true;
  };
}