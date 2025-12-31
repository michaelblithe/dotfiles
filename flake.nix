{
  description = "Alex's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, disko, nix-vscode-extensions, nur, ... }: 

    let 
      configuration = { pkgs, ... }: { 
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          nix-vscode-extensions.overlays.default
          nur.overlays.default
        ];
      };
    in  {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { 
            nixpkgs.overlays = [ 
              nix-vscode-extensions.overlays.default
              nur.overlays.default
            ]; 
            nixpkgs.config.allowUnfree = true;
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alex = import ./home/alex;
            home-manager.extraSpecialArgs = { hostname = "thinkpad"; };
          }
          ./hosts/thinkpad
        ];
        specialArgs = { inherit self; };
      };
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          configuration
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alex = import ./home/alex;
            home-manager.extraSpecialArgs = { hostname = "framework"; };
          }
          ./hosts/framework
        ];
        specialArgs = { inherit self inputs; };
      };
    };
  };
}
