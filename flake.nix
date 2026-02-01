{
  description = "Alex's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      url = "github:ggml-org/llama.cpp/0c3b7a9efebc73d206421c99b7eb6b6716231322";
    };

  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , disko
    , nix-vscode-extensions
    , nur
    , sops-nix
    , llama-cpp
    , ...
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
              home-manager.users.alex = import ./home/alex;
              home-manager.extraSpecialArgs = {
                hostname = "luna";
              };
            }
            ./hosts/luna
          ];
          specialArgs = { inherit self inputs; };
        };
      };
    };
}
