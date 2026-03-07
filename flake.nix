{
  description = "OpenCode CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      version = "1.2.20";

      mkOpencode = system: pkgs:
        let
          platformInfo = {
            "aarch64-darwin" = {
              platform = "darwin-arm64";
              extension = "zip";
              sha256 = "10aaxg1nsncj76cmyh6whrzjjiqd8zxhgcaz2m9fri7xpxb60f10";
            };
            "aarch64-linux" = {
              platform = "linux-arm64-musl";
              extension = "tar.gz";
              sha256 = "04wcdcryvvj5hddy7j78xbwip0y65nrmxvhdjrldgmmm0s5jdm2k";
            };
          }.${system};
        in
        pkgs.stdenv.mkDerivation {
          pname = "opencode";
          inherit version;

          src = pkgs.fetchurl {
            url = "https://github.com/anomalyco/opencode/releases/download/v${version}/opencode-${platformInfo.platform}.${platformInfo.extension}";
            sha256 = platformInfo.sha256;
          };

          nativeBuildInputs = if pkgs.stdenv.isDarwin then [ pkgs.unzip ] else [];

          # Don't strip - corrupts Bun single-file executable
          dontStrip = true;

          unpackPhase = if platformInfo.extension == "zip" then ''
            unzip $src
          '' else ''
            tar xf $src
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp opencode $out/bin/
            chmod +x $out/bin/opencode
          '';

          meta = with pkgs.lib; {
            description = "AI coding assistant";
            homepage = "https://opencode.ai";
            license = licenses.mit;
            mainProgram = "opencode";
          };
        };

    in
    {
      packages.aarch64-darwin.default = mkOpencode "aarch64-darwin" nixpkgs.legacyPackages.aarch64-darwin;
      packages.aarch64-darwin.opencode = self.packages.aarch64-darwin.default;
      packages.aarch64-linux.default = mkOpencode "aarch64-linux" nixpkgs.legacyPackages.aarch64-linux;
      packages.aarch64-linux.opencode = self.packages.aarch64-linux.default;

      apps.aarch64-darwin.default = {
        type = "app";
        program = "${self.packages.aarch64-darwin.default}/bin/opencode";
      };
      apps.aarch64-linux.default = {
        type = "app";
        program = "${self.packages.aarch64-linux.default}/bin/opencode";
      };
    };
}
