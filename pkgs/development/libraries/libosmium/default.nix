{ lib, stdenv, fetchFromGitHub, cmake, protozero, expat, zlib, bzip2, boost }:

stdenv.mkDerivation rec {
  pname = "libosmium";
  version = "2.17.1";

  src = fetchFromGitHub {
    owner = "osmcode";
    repo = "libosmium";
    rev = "v${version}";
    sha256 = "sha256-riNcIC60gw9qxF8UmPjq03XuD3of0BxKbZpgwjMNh3c=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ protozero zlib bzip2 expat boost ];

  cmakeFlags = [ "-DINSTALL_GDALCPP:BOOL=ON" ];

  doCheck = true;

  meta = with lib; {
    description = "Fast and flexible C++ library for working with OpenStreetMap data";
    homepage = "https://osmcode.org/libosmium/";
    license = licenses.boost;
    maintainers = with maintainers; [ das-g ];
  };
}
