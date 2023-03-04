{ fetchFromGitHub
, fetchpatch
, lib
, rustPlatform
, withCmd ? false
}:

rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "unstable-2023-03-01";

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "6fd8e9c14b217c04c6f5c3a2ace55ccf2ac54252";
    sha256 = "sha256-d/zU0rbqeelk9ptTppUentDjTvo7fFdAy2+o8ojmei4=";
  };

  cargoHash = "sha256-huVWawVBiEhaEDDU63l9c5e7hqjlUqVYLnpqeutPlws=";

  buildFeatures = lib.optional withCmd "cmd";

  postInstall = ''
    install -Dm 444 assets/kanata-icon.svg $out/share/icons/hicolor/scalable/apps/kanata.svg
  '';

  meta = with lib; {
    description = "A tool to improve keyboard comfort and usability with advanced customization";
    homepage = "https://github.com/jtroo/kanata";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ linj ];
    platforms = platforms.linux;
  };
}
