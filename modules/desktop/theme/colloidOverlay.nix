self: super: {
  colloid-gtk-theme = super.colloid-gtk-theme.overrideAttrs (oldAttrs: {
    preInstall = ''
      sed -in "s/theme_color_dark='#1e66f5'/theme_color_dark='#8aadf4'/g" assets.sh
      sed -in "s/theme_color_light='#8caaee'/theme_color_light='#91d7e3'/g" assets.sh

      sed -in "s/background_dark='#292c3c'/background_dark='#24273A'/g" assets.sh
      sed -in "s/background_darker='#303446'/background_darker='#181926'/g" assets.sh
      sed -in "s/titlebar_dark='#24273a'/titlebar_dark='#24273a'/g" assets.sh

      sed -in "s/button_close='#ea999c'/button_close='#ed8796'/g" assets.sh
      sed -in "s/button_max='#a6d189'/button_max='#a6da95'/g" assets.sh
      sed -in "s/button_min='#e5c890'/button_min='#eed49f'/g" assets.sh

      echo "asssets"
      cat assets.sh

      sed -in "s/theme_color_dark='#1e66f5'/theme_color_dark='#8aadf4'/g" gtkrc.sh
      sed -in "s/theme_color_light='#8caaee'/theme_color_light='#91d7e3'/g" gtkrc.sh

      sed -in "s/background_dark='#292c3c'/background_dark='#24273A'/g" gtkrc.sh
      sed -in "s/background_darker='#303446'/background_darker='#181926'/g" gtkrc.sh
      sed -in "s/titlebar_dark='#24273a'/titlebar_dark='#24273a'/g" gtkrc.sh

      sed -in "s/button_close='#ea999c'/button_close='#ed8796'/g" gtkrc.sh
      sed -in "s/button_max='#a6d189'/button_max='#a6da95'/g" gtkrc.sh
      sed -in "s/button_min='#e5c890'/button_min='#eed49f'/g" gtkrc.sh
      echo "gtkrc"

      cat gtkrc.sh

      sed -in "s/theme_color='#8caaee'/theme_color='#91d7e3'/g" src/assets/gtk-2.0/make-assets.sh
      sed -in "s/background_color='#292c3c'/theme_color='#24273A'/g" src/assets/gtk-2.0/make-assets.sh
      echo "makeassets"

      cat src/assets/gtk-2.0/make-assets.sh

    '';
  });

  colloid-icon-theme = super.colloid-icon-theme.overrideAttrs (oldAttrs: {
    installPhase =
      ''
        sed -i "s/theme_color='#f4b8e4'/theme_color='#f0c6c6'/g" lib_colors.sh
      ''
      + (oldAttrs.installPhase or "");
  });
}
