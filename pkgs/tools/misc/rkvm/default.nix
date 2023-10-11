{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libevdev
, openssl
, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname = "rkvm";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "htrefil";
    repo = pname;
    rev = version;
    hash = "sha256-xwyQ154VdXHzq5tEAq2SbsULTg3c3Dn6OT43T7UMm7o=";
  };

  cargoHash = "sha256-KIsvA3dHNeBf/bDncMTnXNI3TcADgMPMXb+Tv+dU2Nc=";

  nativeBuildInputs = [ pkg-config rustPlatform.bindgenHook makeWrapper ];
  buildInputs = [ libevdev ];

  postInstall = ''
    install -Dm444 -t "$out/lib/systemd/system" systemd/rkvm-*.service
    install -Dm444 example/server.toml "$out/etc/rkvm/server.example.toml"
    install -Dm444 example/client.toml "$out/etc/rkvm/client.example.toml"

    wrapProgram $out/bin/rkvm-certificate-gen --prefix PATH : ${lib.makeBinPath [ openssl ]}
  '';

  meta = with lib; {
    description = "Virtual KVM switch for Linux machines";
    homepage = "https://github.com/htrefil/rkvm";
    changelog = "https://github.com/htrefil/rkvm/releases/tag/${version}";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ckie ];
  };
}
