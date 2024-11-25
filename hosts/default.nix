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
  ];

  # Select internationalisation properties.

  environment.systemPackages = with pkgs; [
    firefox-devedition
  ];

}
