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
  ];

  stylix.targets.gtk.enable = false;

  # Select internationalisation properties.

  users.users.niko = {
    isNormalUser = true;
    description = "Nikolaj";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
  };

  environment.systemPackages = with pkgs; [
    firefox-devedition
  ];

  programs.zsh = {
    enable = true;
  };

  users.users.niko = {
    shell = pkgs.zsh;
  };
}
