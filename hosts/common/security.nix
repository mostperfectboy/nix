{ ... }:
{
  services = {
    gnome.gnome-keyring = {
      enable = true;
    };
    passSecretService.enable = true;
  };
  security.pam.services.login.enableGnomeKeyring = true;
  environment.variables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  };
  security.polkit.enable = true;
}
