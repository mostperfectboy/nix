{
  description = "Niko's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-tools.url = "github:mostperfectboy/llm-tools.nix";
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
      lib = import ./lib {
        inherit
          nixpkgs
          home-manager
          catppuccin
          nixos-hardware
          inputs
          ;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      nixosConfigurations = {
        gom = lib.mkSystem "gom" {
          hardwareModule = nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4;
        };
        boldan = lib.mkSystem "boldan" { };
        barlow = lib.mkSystem "barlow" { };
      };

      homeConfigurations = {
        "niko@gom" = lib.mkHome {
          hostname = "gom";
          username = "niko";
        };
        "niko@boldan" = lib.mkHome {
          hostname = "boldan";
          username = "niko";
        };
        "niko@barlow" = lib.mkHome {
          hostname = "barlow";
          username = "niko";
        };
      };
    };
}
