{ fetchFromGitHub
, fetchpatch
, lib
, rustPlatform
, withCmd ? false
}:

rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "unstable-2023-02-26";

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "2223279c01f88442b39bfc1220916286eec3e2e0";
    sha256 = "sha256-46IMeb/hj4i+NFwIQCqaJKzAydeyMbTfSNz2tn1nPAY=";
  };

  cargoHash = "sha256-gUaBaWxt5G6R/+KnXMa+7U2E1AYLT2tWVHqft8zqCRc=";

  buildFeatures = lib.optional withCmd "cmd";

  postInstall = ''
    install -D assets/kanata-icon.svg $out/share/icons/hicolor/scalable/apps/kanata.svg
  '';

  meta = with lib; {
    description = "A tool to improve keyboard comfort and usability with advanced customization";
    homepage = "https://github.com/jtroo/kanata";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ linj ];
    platforms = platforms.linux;
  };
}
