{ pkgs, ... }:
{
  programs = {
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
        "popencode" = "pnpx opencode-ai@latest";
        "codex" = "pnpx @openai/codex";
      };
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
      enableInteractive = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
    };
  };
  home.packages = with pkgs; [
    docker-credential-helpers
  ];
}
