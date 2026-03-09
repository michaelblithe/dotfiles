{
  description = "Alex's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
    nur = {
      url = "github:nix-community/NUR";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llama-cpp = {
      url = "github:ggml-org/llama.cpp/17a42589467165be7114b79797e794716b30ace3";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
    };

    ags = {
      url = "github:aylur/ags";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      disko,
      nix-vscode-extensions,
      nur,
      sops-nix,
      llama-cpp,
      nixos-hardware,
      nix-darwin,
      ...
    }:

    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
            nur.overlays.default
          ];
        };
    in
    {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/alex;
              home-manager.extraSpecialArgs = {
                hostname = "thinkpad";
              };
            }
            ./hosts/thinkpad
            nixos-hardware.nixosModules.lenovo-thinkpad-x230
          ];
          specialArgs = { inherit self inputs; };
        };
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/alex;
              home-manager.extraSpecialArgs = {
                hostname = "framework";
              };
            }
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [ (import ./overlays/llama.cpp-vulkan.nix llama-cpp) ];
            }
            ./hosts/framework
            nixos-hardware.nixosModules.framework-13th-gen-intel
          ];
          specialArgs = { inherit self inputs; };
        };
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/alex;
              home-manager.extraSpecialArgs = {
                hostname = "house-of-wind";
              };
            }
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [ (import ./overlays/llama.cpp-full.nix llama-cpp) ];
            }
            ./hosts/desktop
            ./modules/openssh
            nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
          ];
          specialArgs = { inherit self inputs; };
        };
        luna = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/luna;
              home-manager.extraSpecialArgs = {
                hostname = "luna";
              };
            }
            ./hosts/luna
          ];
          specialArgs = { inherit self inputs; };
        };
      };
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager.sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          ./hosts/macbook
        ];
        specialArgs = { inherit inputs self; };
      };
    };

    devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            nixpkgs-fmt
            statix
            deadnix
          ];
        };
      }
    );

}
