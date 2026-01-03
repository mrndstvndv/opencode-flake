{
  description = "OpenCode CLI with optional dev tools (ktlint, ruff, pyright, nixd)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      version = "1.0.223";

      opencode = pkgs.stdenv.mkDerivation {
        pname = "opencode";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://github.com/anomalyco/opencode/releases/download/v${version}/opencode-darwin-arm64.zip";
          sha256 = "1b6gvczl07671qwd4yrdix5wcbaggvsd3rx4frazwpwlfvsc5nr6";
        };

        nativeBuildInputs = [ pkgs.unzip ];

        unpackPhase = ''
          unzip $src
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp opencode $out/bin/
          chmod +x $out/bin/opencode
        '';

        meta = with pkgs.lib; {
          description = "AI coding assistant";
          homepage = "https://opencode.ai";
          platforms = [ "aarch64-darwin" ];
          mainProgram = "opencode";
        };
      };

      opencode-full = pkgs.symlinkJoin {
        name = "opencode-full-${version}";
        paths = [
          opencode
          pkgs.ktlint
          pkgs.ruff
          pkgs.pyright
          pkgs.nixd
        ];
        meta.mainProgram = "opencode";
      };

    in {
      packages.${system} = {
        inherit opencode opencode-full;
        default = opencode;
      };

      apps.${system}.default = {
        type = "app";
        program = "${opencode}/bin/opencode";
      };
    };
}
