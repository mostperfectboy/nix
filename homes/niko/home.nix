{ ... }:
{
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./shell.nix
    ./desktop.nix
    ./dev.nix
  ];

  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
      "ssh"
    ];
  };

  home.file = {
    ".docker/config.json".text = ''{"credsStore": "secretservice"}'';
    ".XCompose".source = ./.XCompose;
  };

  programs.home-manager.enable = true;
}
