{ fetchFromGitHub
, fetchpatch
, lib
, rustPlatform
, withCmd ? false
}:

rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "unstable-2023-02-25";

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "010b52b2214019e990024a89bab2351544667042";
    sha256 = "sha256-GfLRpEO1ryI+eZCXpsW5OWSBEk3fV4G76EgIKxC9wec=";
  };

  cargoHash = "sha256-tiMNoP0JBlUwSa9SrTVcEqgsMUpJf9hpZKyi5v007jk=";

  buildFeatures = lib.optional withCmd "cmd";

  meta = with lib; {
    description = "A tool to improve keyboard comfort and usability with advanced customization";
    homepage = "https://github.com/jtroo/kanata";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ linj ];
    platforms = platforms.linux;
  };
}
