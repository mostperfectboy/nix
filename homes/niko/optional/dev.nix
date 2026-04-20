{ pkgs, ... }:
{
  imports = [ ./dev/vscode.nix ];
  home = {
    packages = with pkgs; [
      slack
      teams-for-linux
      chromium
      devenv
      corepack_24
      nodejs_latest
      playwright-driver.browsers
    ];

    sessionVariables = {
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    };
  };
  xdg.desktopEntries = {
    linear = {
      name = "Linear";
      exec = "chromium --app=https://linear.app";
    };
  };
}
