{ trivialBuild
, lib
, fetchFromGitHub
, curl
, plz
, cl-lib
, ts
, taxy
, taxy-magit-section
}:

trivialBuild {
  pname = "ement";
  version = "unstable-2022-04-12";

  src = fetchFromGitHub {
    owner = "alphapapa";
    repo = "ement.el";
    rev = "b956d368ffb6ed93d01e697d44d7158f4d300511";
    sha256 = "sha256-qloMlFhlZJILzyNxrW10NlIggP4Bj2wSCSWM2dlMly0=";
  };

  packageRequires = [
    plz
    cl-lib
    ts
    taxy
    taxy-magit-section
  ];

  patches = [
    ./handle-nil-images.patch
  ];

  meta = {
    description = "Ement.el is a Matrix client for Emacs";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
}
