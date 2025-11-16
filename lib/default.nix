{
  nixpkgs,
  home-manager,
  catppuccin,
  nixos-hardware,
  inputs,
  ...
}:
let
  mkSystem =
    hostname:
    {
      hardwareModule ? null,
      specialArgs ? { },
    }:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs hostname;
        username = "niko";
      } // specialArgs;
      modules =
        [
          catppuccin.nixosModules.catppuccin
          ../hosts/common/global/default.nix
          ../hosts/${hostname}/default.nix
        ]
        ++ (if hardwareModule != null then [ hardwareModule ] else [ ]);
    };

  mkHome =
    {
      hostname,
      username ? "niko",
    }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        catppuccin.homeModules.catppuccin
        ../homes/${username}/global/default.nix
        ../homes/${username}/${hostname}.nix
      ];
      extraSpecialArgs = {
        inherit inputs hostname username;
        system = "x86_64-linux";
      };
    };
in
{
  inherit mkSystem mkHome;
}
