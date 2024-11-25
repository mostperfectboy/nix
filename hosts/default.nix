{
  pkgs,
  ...
}:
{

  imports = [
    # Include the results of the hardware scan.
    ./common/locale.nix
    ./common/nix.nix
    ./common/security.nix
    ./common/docker.nix
    ./common/user.nix
    ./common/theme.nix
    ./common/desktop/hyprland.nix
    ./common/desktop/thunar.nix
  ];

  # Select internationalisation properties.

  environment.systemPackages = with pkgs; [
    firefox-devedition
  ];

}
