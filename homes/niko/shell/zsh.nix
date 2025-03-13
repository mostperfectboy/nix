{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      autosuggestion = {
        enable = true;
      };
      enableCompletion = true;
      shellAliases = {
        la = "ls -hal";
        ".." = "cd ..";
        "..." = "cd ..";
        "dcud" = "docker compose up -d";
        "dc" = "docker compose";
      };
    };

    fish = {
      enable = true;
      shellAbbrs = {
        la = "ls -hal";
        ".." = "cd ..";
        "..." = "cd ..";
        "dcud" = "docker compose up -d";
        "dc" = "docker compose";
      };
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./posh.json));
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;  # Adding Fish integration
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
  home.packages = with pkgs; [
    zsh-fzf-tab
    docker-credential-helpers
  ];
}
