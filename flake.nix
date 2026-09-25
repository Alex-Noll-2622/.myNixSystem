{

  description = "the flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos-btw = lib.nixosSystem {
          inherit system;
	  modules = [
	    stylix.nixosModules.stylix
            ./system/configuration.nix
	  ];
	};
      };
      homeConfigurations = {
        alexnoll = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
	  modules = [
	    stylix.homeModules.stylix
            ./home.nix
	  ];
	};
      };
    };
}
