{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      packageOverrides = self: super: {
        django-ogcapif = self.callPackage ./django-ogcapif.nix { };
        djangorestframework-gis = self.callPackage ./django-rest-framework-gis.nix { };
        transifex-client = self.callPackage ./transifex-client.nix { };
        django-computedfields = self.callPackage ./django-computedfields.nix { };
        django = super.django.override { withGdal = true; };
      };

      python = pkgs.python3.override {
        inherit packageOverrides;
        self = python;
      };

      pythonEnv = python.withPackages (ps: [ ps.django-ogcapif ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pythonEnv ];
      };
    };
}
