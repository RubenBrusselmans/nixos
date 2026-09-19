{
  description = "NixOS with Flakes and Home Manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      hostsDir = builtins.readDir ./hosts;
      hostNames = builtins.attrNames (nixpkgs.lib.filterAttrs (_: type: type == "directory") hostsDir);
      mkHost = host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            # expose unstable to every module as pkgs.unstable
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = inputs.nixpkgs-unstable.legacyPackages.${final.stdenv.hostPlatform.system};
                })
              ];
            }
            ./hosts/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      nixosConfigurations = builtins.listToAttrs (map mkHost hostNames);
    };
}
