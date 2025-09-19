{ inputs, ... }:
{
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable { system = final.system; };
  };

  neovim-config = _final: prev: {
    neovim-config = prev.stdenv.mkDerivation {
      name = "neovim-config";
      src = inputs.nixpkgs.neovim-config;
    };
  };
}
