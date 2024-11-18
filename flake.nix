{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "https://github.com/hyprwm/Hyprland";
      type = "git";
      submodules = true;
    };
    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ags.url = "github:Aylur/ags";
  };

  outputs =
    {
      home-manager,
      nixos-hardware,
      nixpkgs,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "niko";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          stylix.nixosModules.stylix
          # home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
          ./modules/configuration.nix
          # {
          #   home-manager.users.${username} = {
          #     imports = [
          #       # ./modules/home.nix
          #     ];
          #   };
          # }
        ];
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          stylix.homeManagerModules.stylix
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit inputs system username;
        };
      };
    };
}
