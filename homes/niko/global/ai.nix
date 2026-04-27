{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser
    ast-grep
    python3
    gh
  ];

  programs = {
    git.ignores = [
      ".opencode"
      "AGENTS.md"
      ".agents"
      "skills-lock.json"
    ];

    fish = {
      shellAbbrs = {
        oc = "opencode";
      };

      shellAliases = {
        claude = "pnpx @anthropic-ai/claude-code@latest";
        popencode = "pnpx opencode-ai@latest";
        codex = "pnpx @openai/codex";
        skills = "npx skills --agent universal --yes";
      };
    };
  };
}
