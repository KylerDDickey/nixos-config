{
  description = "NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          shellHook = ''
            build_nixos() {
              echo "NixOS rebuild requires root permissions."
              sudo -- sh -c './scripts/build.sh'
              sudo -k
            }
          '';
        };
      });
    };
}
