{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  makeWrapper,
  nodejs,
  playwright-driver,
  pnpm_10,
  pnpmConfigHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "next-browser";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "vercel-labs";
    repo = "next-browser";
    tag = "v${finalAttrs.version}";
    hash = "sha256-uNb1i+1ktofmi6+cEWlGsweHErgxAGPQ7DKMhCZmjYU=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-zmiB9fPbqvSY17DR7vyJQBuUmNe9aQGExoanioMxfNY=";
  };

  nativeBuildInputs = [
    makeWrapper
    nodejs
    pnpm_10
    pnpmConfigHook
  ];

  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -d "$out/bin" "$out/lib/node_modules/${finalAttrs.pname}"
    cp -r dist extensions node_modules package.json "$out/lib/node_modules/${finalAttrs.pname}"

    makeWrapper ${nodejs}/bin/node "$out/bin/next-browser" \
      --add-flags "$out/lib/node_modules/${finalAttrs.pname}/dist/cli.js" \
      --set-default PLAYWRIGHT_BROWSERS_PATH ${playwright-driver.browsers} \
      --set-default PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true

    runHook postInstall
  '';

  meta = {
    description = "Headed Playwright browser for Next.js agent workflows";
    homepage = "https://github.com/vercel-labs/next-browser";
    changelog = "https://github.com/vercel-labs/next-browser/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    mainProgram = "next-browser";
    platforms = lib.platforms.all;
  };
})
