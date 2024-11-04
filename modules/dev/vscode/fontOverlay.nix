self: super: {
  vscode = super.vscode.overrideAttrs (oldAttrs: {
    postPatch =
      oldAttrs.postPatch
      + ''
        echo '.mtki { font-family: VictorMono Nerd Font Mono, Operator Mono Lig, Operator Mono; font-weight: 700 !important } ' >> ./resources/app/out/vs/workbench/workbench.desktop.main.css
      '';
  });
}
