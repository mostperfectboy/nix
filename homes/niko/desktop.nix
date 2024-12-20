{ pkgs, inputs, ... }:
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop/applications.nix
    ./desktop/waybar.nix
    ../../pkgs/stylix.nix
    inputs.ags.homeManagerModules.default
  ];
  nixpkgs.overlays = [ (import ./desktop/theme/colloidOverlay.nix) ];

  home = {
    packages = with pkgs; [
      kanshi
      wl-clipboard
      cliphist
      pavucontrol
      pamixer
      lxqt.lxqt-policykit
      xdg-utils
      firefox
      seahorse
      dconf
      grim
      slurp
    ];
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "16x16";
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  programs.ags = {
    enable = true;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      battery
      hyprland
      network
      wireplumber
      tray
    ];
  };

  stylix = {
    enable = true;
    image = ./mountain.jpg;
    autoEnable = true;
    targets = {
      gtk.enable = false;
      hyprlock.enable = false;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Colloid-Pink-Catppuccin";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = [ "catppuccin" ];
        colorVariants = [ "pink" ];
      };
    };
    theme = {
      name = "Colloid-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        tweaks = [ "catppuccin" ];
      };
    };
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        output.criteria = "eDP-1";
        output.scale = 1.5;
      }
      {
        profile.name = "default";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "office";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            mode = "1920x1200";
            scale = 1.5;
            position = "1920,1080";
          }
          {
            criteria = "Samsung Electric Company C27F390 H4LR903256";
            mode = "1920x1080";
            position = "0,0";
          }
          {
            criteria = "Samsung Electric Company C27F390 H4ZT800578";
            mode = "1920x1080";
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "DP-8";
            mode = "2560x1440";
            position = "2360,480";
            scale = 1.25;
          }
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            scale = 1.5;
            position = "0,1280";
          }
          {
            criteria = "DP-11";
            mode = "1920x1080@60";
            position = "1280,0";
            transform = "90";
          }
        ];
      }
    ];
  };
  services.mako = {
    enable = true;
    borderRadius = 4;
    extraConfig = ''
      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
