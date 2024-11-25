{
  inputs,
  pkgs,
  ...
}:
{

  # Nix settings
  nix = {
    # Store optimization
    optimise = {
      automatic = true;
      dates = [ "13:00" ];
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # nixpkgs instance config
  nixpkgs = {
    config = {
      # Always allow unfree packages
      allowUnfree = true;
    };
  };

  imports = [
    # Include the results of the hardware scan.
    ../pkgs/stylix.nix
    ./common/locale.nix
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

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
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

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # NixOS release
  system.stateVersion = "23.11";
}
