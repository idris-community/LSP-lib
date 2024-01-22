{
  description = "Library for building out LSPs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    idris.url = "github:idris-lang/Idris2";
    idris.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, idris }:
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
  };
}
