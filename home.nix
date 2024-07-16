{ pkgs, ... }:
{
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/shell.nix
    ./modules/desktop.nix
    ./modules/dev.nix
  ];

  catppuccin = {
    enable = true;
    accent = "maroon";
    flavor = "frappe";
  };

  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
      "ssh"
    ];
  };

  home.file = {
    ".docker/config.json".source = ./home/docker/config.json;
    ".XCompose".source = ./home/.XCompose;
  };

  programs.home-manager.enable = true;
}
