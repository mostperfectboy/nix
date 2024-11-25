{ username, pkgs, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Nikolaj";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh = {
    enable = true;
  };
}
