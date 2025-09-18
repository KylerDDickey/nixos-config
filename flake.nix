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
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    in
    {
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

      packages = eachSystem (pkgs: {
        default = pkgs.stdenv.mkDerivation (finalAttrs: {
          name = "nixos-kdd";
          # pname = "";
          # version = "";
          #
          src = "./";
          #
          # nativeBuildInputs = [
          #
          # ];
          buildInputs = [
            pkgs.sudo
          ];
          #
          # meta = {
          #   description = "";
          #   homepage = "";
          #   license = lib.licenses.;
          #   maintainers = with lib.maintainers; [  ];
          # };

          builder = ./scripts/build.sh;
        });
      });
    };
}
