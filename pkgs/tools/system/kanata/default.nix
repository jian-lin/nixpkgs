{ fetchFromGitHub
, fetchpatch
, lib
, rustPlatform
, withCmd ? false
}:

rustPlatform.buildRustPackage rec {
  pname = "kanata";
  version = "unstable-2022-08-25";

  src = fetchFromGitHub {
    owner = "jtroo";
    repo = pname;
    rev = "aa8298dbec140d68ca8bf182ff5ed43f50071402";
    hash = "sha256-hCG4bzU3shPtxnLP6mHzUYCFaciU0T7RQxEbERip7Gk=";
  };

  cargoHash = "sha256-jBiNEPZzgN3d0egj88G0+S+APlzDbX3N6DYh7FF/I14=";

  cargoPatches = [
    (fetchpatch {
      name = "fix-high-cpu-usage.patch";
      url = "https://github.com/jtroo/kanata/pull/114.patch";
      hash = "sha256-ItUX6qsRRiIKOcxoRBAZ7S+Frc+fbOAG/cb8JLNlYeg=";
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
