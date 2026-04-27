{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
