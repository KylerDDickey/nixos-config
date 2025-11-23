{
  description = "NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    neovim-config = {
      url = "github:KylerDDickey/nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      meta = import ./meta { };

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations.personalLaptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/personal-laptop/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
