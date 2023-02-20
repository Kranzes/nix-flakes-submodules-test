{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.self.submodules = true;
  inputs.extra-submodules = {
    url = "git+https://github.com/Kranzes/nix-flakes-submodules-test?ref=extra-submodules";
    submodules = true;
    flake = false;
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.runCommand "submodules-test" { } ''
        mkdir $out
        echo -e "\033[1;33mPrinting from inputs.self's submodules...\033[0m"
        cat ${inputs.self}/nix/README.md | tee $out/nix-README.md
        echo -e "\033[1;33mPrinting from inputs.extra-submodules's submodules...\033[0m"
        cat ${inputs.extra-submodules}/templates/README.md | tee $out/templates-README.md
      '';
    };
}
