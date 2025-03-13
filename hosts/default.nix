{
  ...
}:
{
  imports = [
    ./common/locale.nix
    ./common/nix.nix
    ./common/security.nix
    ./common/docker.nix
    ./common/user.nix
    ./common/theme.nix
    ./common/desktop/hyprland.nix
    ./common/desktop/filemanager.nix
  ];

  users.motd = "";
}
