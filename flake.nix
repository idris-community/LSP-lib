{
  description = "Library for building out LSPs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    # tmp url:
    idris.url = "github:mattpolzin/Idris2/nix-idrisapi";
  };

  outputs = { self, nixpkgs, idris }:
    let
      lib = nixpkgs.lib;
      # support the same systems as Idris2
      systems = builtins.attrNames idris.packages;
    in
    { packages = lib.genAttrs systems (system:
      let
        idrisPkgs = idris.packages.${system};
        buildIdris = idris.buildIdris.${system};

        lspLibPkg = buildIdris {
          projectName = "LSP-lib";
          src = ./.;
          idrisLibraries = [ ];
        };
      in rec {
        lsp-lib = lspLibPkg.library { };
        default = lsp-lib;
      }
    );
  };
}
