{
  description = "Library for building out LSPs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    idris.url = "github:idris-lang/Idris2";
    idris.inputs.nixpkgs.follows = "nixpkgs";

    # chicken-and-egg situation: we don't want the version of the
    # LSP we use to develop this package to use the version of Idris
    # we are currently developing against or else you could not use
    # a functioning LSP while addressing breaking changes.
    idris2Lsp.url = "github:idris-community/idris2-lsp";
    idris2Lsp.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, idris, idris2Lsp, ... }:
    let
      lib = nixpkgs.lib;
      # support the same systems as Idris2
      systems = builtins.attrNames idris.packages;
    in
    { packages = lib.genAttrs systems (system:
      let
        buildIdris = idris.buildIdris.${system};

        lspLibPkg = buildIdris {
          ipkgName = "lsp-lib";
          version = "0.1.0";
          src = ./.;
          idrisLibraries = [ ];
        };
      in rec {
        lspLib = lspLibPkg.library { };
        lspLibWithSrc = lspLibPkg.library { withSource = true; };
        default = lspLib;
      }
    );
    devShells = lib.genAttrs systems (system:
      { default = nixpkgs.legacyPackages.${system}.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          packages = [ idris2Lsp.packages.${system}.default ];
        };
      }
    );
  };
}
