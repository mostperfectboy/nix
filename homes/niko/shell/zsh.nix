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
        "oc" = "opencode";
      };
      shellAliases = {
        "claude" = "pnpx @anthropic-ai/claude-code@latest";
        "opencode" = "pnpx opencode-ai@latest";
        "codex" = "pnpx @openai/codex";
      };
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableTransience = true;
      enableInteractive = true;
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
      enableFishIntegration = true; # Adding Fish integration
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
