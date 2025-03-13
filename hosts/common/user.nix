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
    shell = pkgs.fish;
  };
  programs.zsh = {
    enable = true;
  };
  programs.fish = {
    enable = true;
  };
}
