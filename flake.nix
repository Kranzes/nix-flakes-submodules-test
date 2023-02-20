{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.self.submodules = true;

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.runCommand "submodules-test" { } ''
        mkdir $out
        cat ${inputs.self}/nix/README.md | tee $out/README.md
      '';
    };
}
