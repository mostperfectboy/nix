{ inputs, ... }:
{
  nix = {
    optimise = {
      automatic = true;
      dates = [ "13:00" ];
    };
    gc = {
      automatic = true;
      dates = [ "03:00" ];
      options = "--delete-older-than 14d";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.nix-ld = {
    enable = true;
  };

}
