self: super: {
  vscode = super.vscode.overrideAttrs (oldAttrs: rec {
    postPatch = oldAttrs.postPatch + ''
      echo '.mtki { font-family: Operator Mono Lig, Operator Mono; } ' >> ./resources/app/out/vs/workbench/workbench.desktop.main.css
    '';
  });
}