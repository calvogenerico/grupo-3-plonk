{
  description = "Node.js development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      inherit (pkgs) nodejs;

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs
          pnpm
        ];
      };
    };
}
