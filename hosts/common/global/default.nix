# Mandatory configuration for all hosts
{ ... }:
{
  imports = [
    ./locale.nix
    ./nix.nix
    ./security.nix
    ./user.nix
    ./theme.nix
  ];
}
