{ inputs, ... }:
{
  nix = {
    optimise = {
      automatic = true;
      dates = [ "13:00" ];
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
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

  system.stateVersion = "23.11";
}
