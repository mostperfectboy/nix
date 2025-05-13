{ pkgs, ... }:
{
  imports = [ ./shell/zsh.nix ];

  home.packages = with pkgs; [
    wget
    nixd
    nixfmt-rfc-style
  ];

  programs = {
    git = {
      enable = true;
      userName = "Niko";
      userEmail = "git@undefine.dev";
      extraConfig = {
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        init.defaultBranch = "main";
        diff = {
          algorithm = "histogram";
          mnemonicPrefix = true;
          rename = true;
        };
        push = {
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
        help.autocorrect = true;
        pull.rebase = true;
      };
    };
    gitui = {
      enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
    };
    zellij = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
