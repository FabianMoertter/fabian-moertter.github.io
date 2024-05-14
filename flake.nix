{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default = let
        pkgs = import nixpkgs {
          inherit system;
        };
      in pkgs.mkShell {
        packages = with pkgs; [
	  go
          hugo
	  nodejs
        ];
	shellHook = ''
	  hugo mod tidy
	  hugo mod npm pack
	  npm install
	  echo 'Flake for Hugo activated'
	'';
      };
    };
}
