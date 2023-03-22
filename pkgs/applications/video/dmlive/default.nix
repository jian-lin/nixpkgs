{ lib
, stdenv
, rustPlatform
, fetchFromGitHub
, pkg-config
, makeWrapper
, openssl
, Security
, mpv
, ffmpeg
, nodejs
}:

rustPlatform.buildRustPackage rec {
  pname = "dmlive";
  version = "unstable-2023-03-19";

  src = fetchFromGitHub {
    owner = "THMonster";
    repo = pname;
    rev = "0cc355c0684dc1c058bd3d745a174e4d94b478a5";
    hash = "sha256-SqY/1ZRD9g9HxBrTLYMRUYqOBJaElbP2DuoGM5YfXFY=";
  };

  cargoHash = "sha256-6zrHWC1Q7ctTJ1Z1eei4B/xXB6l51b7lmTwD/xSaGT8=";

  OPENSSL_NO_VENDOR = true;

  nativeBuildInputs = [ pkg-config makeWrapper ];
  buildInputs = [ openssl ] ++ lib.optional stdenv.isDarwin Security;

  postInstall = ''
    wrapProgram "$out/bin/dmlive" --prefix PATH : "${lib.makeBinPath [ mpv ffmpeg nodejs ]}"
  '';

  meta = with lib; {
    description = "A tool to play and record videos or live streams with danmaku";
    homepage = "https://github.com/THMonster/dmlive";
    license = licenses.mit;
    maintainers = with maintainers; [ nickcao ];
  };
}
