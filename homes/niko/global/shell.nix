{ pkgs, inputs, ... }:
{
  imports = [ ./shell/fish.nix ];

  home.packages = with pkgs; [
    wget
    nixd
    nixfmt
    dust
    comma
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
    ast-grep
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser
    (pkgs.callPackage ./shell/next-browser.nix { })
  ];

  programs = {
    keychain = {
      enable = true;
      enableFishIntegration = false;
    };
    git = {
      enable = true;
      ignores = [
        ".opencode"
        "AGENTS.md"
        ".agents"
        "skills-lock.json"
      ];
      settings = {
        user = {
          name = "Niko";
          email = "git@undefine.dev";
        };
        core.excludesFile = "~/.config/git/ignore";
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
        rebase = {
          updateRefs = true;
        };
        help.autocorrect = true;
        pull.rebase = true;
      };
    };
    mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };
    gitui = {
      enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
    };
    ripgrep.enable = true;
    fd.enable = true;
    bat.enable = true;
  };
}
