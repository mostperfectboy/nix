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

  systemd.user.services.gnome-keyring-daemon = {
    Unit = {
      Description = "GNOME Keyring Daemon";
    };
    Service = {
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground --components=pkcs11,secrets,ssh";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.file = {
    ".docker/config.json".text = ''{"credsStore": "secretservice"}'';
    ".XCompose".source = ./.XCompose;
  };

  programs.home-manager.enable = true;
}
