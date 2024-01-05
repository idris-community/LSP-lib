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
          projectName = "LSP-lib";
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
