{
  description = "Description for the project";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        devenv.shells.default = {
          name = "cult-dev";

          imports = [
            # This is just like the imports in devenv.nix.
            # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
            # ./devenv-foo.nix
          ];

          packages = with pkgs; [ hlint fourmolu nil ];

          languages = {
            nix.enable = true;
            haskell = {
              enable = true;
              package = pkgs.ghc;
            };
            javascript = {
              enable = true;
              package = pkgs.nodejs_22;
              pnpm.enable = true;
            };
            typescript.enable = true;
          };

          env = {
            STACK_SYSTEM_GHC = "1";
            STACK_IN_NIX_SHELL = "1";
          };

          git-hooks.hooks = {
            # Nix-specific hooks
            deadnix.enable = true;
            statix.enable = true;
            nixfmt-classic.enable = true;
            nil.enable = true;

            # Haskell hooks
            fourmolu.enable = true;

            # TypeScript/JavaScript hooks
            prettier.enable = true;
            eslint.enable = true;

            # YAML formatting
            yamlfmt.enable = true;
          };

          process.manager.implementation = "process-compose";
          containers = pkgs.lib.mkForce { };
        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
