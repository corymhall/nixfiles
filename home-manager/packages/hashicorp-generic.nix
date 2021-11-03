{ name
, version
, sha256
, system ? builtins.currentSystem
, pname ? "${name}-bin"

, lib
, stdenv
, fetchurl
, unzip
, ...
}:
let
  systemMap = {
    x86_64-linux  = "linux_amd64";
    i686-linux    = "linux_386";
    x86_64-darwin = "darwin_amd64";
    i686-darwin   = "darwin_386";
    aarch64-linux = "linux_arm64";
  };

  goSystem = systemMap.${system} or (throw "unsupported system ${system}");
  url = "https://releases.hashicorp.com/${name}/${version}/${name}_${version}_${goSystem}.zip";
in
  stdenv.mkDerivation rec {
    inherit pname version;

    src = fetchurl { inherit url sha256; };
    sourceRoot = ".";
    nativeBuildInputs = [ unzip ];
    installPhase = ''
      mkdir -p $out/bin
      mv ${name} $out/bin
    '';
}
