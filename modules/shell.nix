{ inputs, pkgs, ... }:
{
  imports = [ ./shell/zsh.nix ];

  home.packages = with pkgs; [
    wget
    git
    nixd
    nh
    gitui
    zellij
    nixfmt-rfc-style
  ];

  programs.git = {
    enable = true;
    userName = "Niko";
    userEmail = "git@undefine.dev";
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
