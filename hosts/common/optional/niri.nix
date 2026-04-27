{ inputs, ... }:
{
  imports = [ inputs.niri.nixosModules.niri ];

  niri-flake.cache.enable = true;

  programs.niri = {
    enable = true;
  };
}
