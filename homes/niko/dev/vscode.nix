{ pkgs, ... }:
{
  nixpkgs.overlays = [ (import ./vscode/fontOverlay.nix) ];
  home.packages = with pkgs; [
    vscode
  ];
  home.file.".vscode/argv.json" = {
    text = builtins.toJSON {
      enable-crash-reporter = false;
      password-store = "gnome";
    };
    force = true;
  };
}
