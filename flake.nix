{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ags.url = "github:Aylur/ags";
  };

  outputs =
    {
      home-manager,
      nixos-hardware,
      nixpkgs,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "niko";
    in
    {
      nixosConfigurations = {
        veldin = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs username;
          };
          modules = [
            catppuccin.nixosModules.catppuccin
            nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
            ./hosts/veldin
          ];
        };
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          catppuccin.homeManagerModules.catppuccin
          ./homes/niko/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs system username;
        };
      };
    };
}
