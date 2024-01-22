{
  description = "Library for building out LSPs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    idris.url = "github:mattpolzin/Idris2/easier-buildIdris-customizations";
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
        lsp-lib = lspLibPkg.library { };
        lsp-lib-with-src = lspLibPkg.library { withSource = true; };
        default = lsp-lib;
      }
    );
  };
}
