# Mandatory home configuration for all hosts
{ ... }:
{
  imports = [
    ./home.nix
    ./shell.nix
  ];
}
