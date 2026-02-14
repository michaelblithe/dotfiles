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
      url = "github:ggml-org/llama.cpp/79cc0f2dafbc7cbbfc37a8d99b399b816e141b90";
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
