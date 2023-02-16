{ fetchFromGitHub
, fetchpatch
, lib
, rustPlatform
, withCmd ? false
}:

rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-mQSbsJ+3mKoDMg0ewwR7UvXUq+5WA9aTPKWCaTz8nDE=";
  };

  cargoHash = "sha256-iLd30aLEIJLYdtsh10KOcoi2+yXZc07Oh9yW1g3EvEo=";

  cargoPatches = [
    (fetchpatch {
      name = "serialize-cfg-parsing-tests-for-1.2.0.patch";
      url = "https://github.com/jtroo/kanata/commit/9ef1e80fbcb40402262e08bd9196d000f73f686d.patch";
      hash = "sha256-/FhyaYx4usDjGoVfRktf9dtwjY4oXdMQKqxLz00/NPY=";
    })
    (fetchpatch {
      name = "notify-systemd-when-kanata-has-finished-starting-up-for-1.2.0.patch";
      url = "https://github.com/jtroo/kanata/commit/c46e0ec88344e4adda5f7cf35fea288eb0d2203a.patch";
      hash = "sha256-ZR9iwr/V9Vplp1+Ubdpls8C0AAI0V5uebx2BibpdxoE=";
    })
  ];

  buildFeatures = lib.optional withCmd "cmd";

  meta = with lib; {
    description = "A tool to improve keyboard comfort and usability with advanced customization";
    homepage = "https://github.com/jtroo/kanata";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ linj ];
    platforms = platforms.linux;
  };
}
