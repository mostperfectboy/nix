self: super: {
  colloid-gtk-theme = super.colloid-gtk-theme.overrideAttrs (oldAttrs: {
    preInstall = ''
      find . -type f \( -name "*.scss" -o -name "*.sh" \) -exec sed -i "
        # red frap -> red mach
        s/#ea999c/#ee99a0/g;
        # pink frap|latte -> flamingo mach|latte
        s/#f4b8e4/#f0c6c6/g;
        s/#ea76cb/#dd7878/g;
        # purple frap -> purple mach
        s/#ca9ee6/#c6a0f6/g;
        # blue frap|latte -> sapphire mach|latte
        s/#8caaee/#85c1dc/g;
        s/#1e66f5/#209fb5/g;
        # teal frap -> teal mach
        s/#81c8be/#8bd5ca/g;
        # green frap -> green mach
        s/#a6d189/#a6da95/g;
        # yellow frap -> yellow mach
        s/#e5c890/#eed49f/g;
        # orange frap -> orange mach
        s/#ef9f76/#f5a97f/g;
        # grey frap -> grey mach
        s/#eff1f5/#edf1fc/g;
        s/#e6e9ef/#cad3f5/g;
        s/#dce0e8/#d2d8f0/g;
        s/#ccd0da/#b8c0e0/g;
        s/#bcc0cc/#afb7da/g;
        s/#acb0be/#a5adcb/g;
        s/#9ca0b0/#9aa1c0/g;
        s/#8c8fa1/#939ab7/g;
        s/#7c7f93/#8087a2/g;
        s/#6c6f85/#6e738d/g;
        s/#5c5f77/#61657f/g;
        s/#4c4f69/#545770/g;
        s/#24273a/#1b1d2a/g;
        s/#303446/#24273a/g;
        # Should be 1e2030 but 24273a is the normal background colour
        s/#292c3c/#24273a/g;
        s/#232634/#181926/g;
        s/#1e1e2e/#151521/g;
        s/#181825/#13131e/g;
        s/#11111b/#10101b/g;
      " {} +
    '';
  });

  colloid-icon-theme = super.colloid-icon-theme.overrideAttrs (oldAttrs: {
    installPhase =
      ''
        sed -i "s/#f4b8e4/#f0c6c6/g" install.sh
      ''
      + (oldAttrs.installPhase or "");
  });
}
