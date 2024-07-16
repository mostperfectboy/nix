{ inputs, pkgs, ... }:
{
  imports = [ ./shell/zsh.nix ];

  home.packages = with pkgs; [
    wget
    git
    nixd
    nh
    mise
    gitui
    zellij
    nixfmt-rfc-style
  ];

  programs.git = {
    enable = true;
    userName = "Niko";
    userEmail = "git@undefine.dev";
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
