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
  ];

  stylix.targets.gtk.enable = false;

  # Select internationalisation properties.

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring = {
    enable = true;
  };
  environment.variables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  };

  virtualisation.docker.enable = true;
  services.passSecretService.enable = true;

  users.users.niko = {
    isNormalUser = true;
    description = "Nikolaj";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
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
