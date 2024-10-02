self: super: {
  vscode = super.vscode.overrideAttrs (oldAttrs: {
    postPatch = oldAttrs.postPatch + ''
      echo '.mtki { font-family: Operator Mono Lig, Operator Mono; } ' >> ./resources/app/out/vs/workbench/workbench.desktop.main.css
    '';
  });
}