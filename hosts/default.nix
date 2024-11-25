{
  pkgs,
  ...
}:
{

  imports = [
    # Include the results of the hardware scan.
    ../pkgs/stylix.nix
    ./common/locale.nix
    ./common/nix.nix
    ./common/keyring.nix
    ./common/docker.nix
    ./common/user.nix
  ];

  stylix.targets.gtk.enable = false;

  # Select internationalisation properties.

  environment.systemPackages = with pkgs; [
    firefox-devedition
  ];

}
