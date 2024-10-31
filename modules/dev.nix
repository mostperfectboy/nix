{ pkgs, ... }:
{
  imports = [ ./dev/vscode.nix ];
  home = {
    packages = with pkgs; [
      slack
      teams-for-linux
    ];
  };
}
