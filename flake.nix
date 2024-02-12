{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    with inputs;
      flake-utils.lib.eachDefaultSystem (
        system: let
          pkgs = import nixpkgs {
            config = {
              allowBroken = false;
              allowUnfree = true;
            };
            inherit system;
          };

          inherit (inputs) self;
        in {
          defaultPackage = pkgs.hello;

          templates = {
            devShell = {
              path = ./templates/dev-shell;
              description = "A simple dev shell ready to be used";
            };

            default = self.templates.devShell;
          };
        }
      );
}
