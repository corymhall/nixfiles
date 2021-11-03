{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.LS_COLORS = {
    url = "github:arcticicestudio/nord-dircolors";
    flake = false;
  };

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.tfenv = {
    url = "github:tfutils/tfenv";
    flake = false;
  };

  outputs = { self, ...  }@inputs:
    let
      overlays = [
        (self: super: {
          zsh-powerlevel10k = super.callPackage ./packages/powerlevel10k.nix {};
        })
        inputs.neovim-nightly-overlay.overlay
        (final: prev: { LS_COLORS = inputs.LS_COLORS; })
      ];
    in
    {
      homeConfigurations = {
        ubuntu-server = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
          {
            xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
            nixpkgs.config = import ./configs/nix/config.nix;
            nixpkgs.overlays = overlays ++[
              (self: super: {
                terraformls = self.callPackage ./packages/hashicorp-generic.nix {
                  name = "terraform-ls";
                  version = "0.22.0";
                  sha256 = "48d18687848251e80f16b9b28593b27aadb8ea0fbe2e6c2cc245f7f55c0b8cbd";
                };
                terraform = self.callPackage ./packages/hashicorp-generic.nix {
                  name = "terraform";
                  version = "1.0.7";
                  sha256 = "bc79e47649e2529049a356f9e60e06b47462bf6743534a10a4c16594f443be7b";
                };
              })

            ];
            imports = [
              ./modules/languages.nix
              ./modules/cli.nix
              ./modules/git.nix
              ./modules/home-manager.nix
              ./modules/neovim.nix
              ./modules/tmux.nix
            ];
          };
          system = "x86_64-linux";
          homeDirectory = "/home/hallcor";
          username = "hallcor";
        };
        mac = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
          {
            xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
            nixpkgs.config = import ./configs/nix/config.nix;
            nixpkgs.overlays = overlays ++[
              (self: super: {
                terraformls = self.callPackage ./packages/hashicorp-generic.nix {
                  name = "terraform-ls";
                  version = "0.22.0";
                  sha256 = "dca81b3899ed505397527b16ca1d86d370534d79254bd01b982f024c2002b8b9";
                };
                terraform = self.callPackage ./packages/hashicorp-generic.nix {
                  name = "terraform";
                  version = "1.0.7";
                  sha256 = "80ae021d6143c7f7cbf4571f65595d154561a2a25fd934b7a8ccc1ebf3014b9b";
                };
              })

            ];
            imports = [
              ./modules/languages.nix
              ./modules/cli.nix
              ./modules/git.nix
              ./modules/home-manager.nix
              ./modules/neovim.nix
              ./modules/tmux.nix
              ./modules/alacritty.nix
            ];
          };
          system = "x86_64-darwin";
          homeDirectory = "/Users/hallcor";
          username = "hallcor";
        };
      };
      ubuntu-server = self.homeConfigurations.ubuntu-server.activationPackage;
      mac = self.homeConfigurations.mac.activationPackage;
    };
}
