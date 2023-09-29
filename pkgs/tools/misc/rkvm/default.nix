{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libevdev
, openssl
, makeWrapper
, fetchpatch
}:

rustPlatform.buildRustPackage rec {
  pname = "rkvm";
  version = "0.4.1-unstable-2023-09-09";

  src = fetchFromGitHub {
    owner = "htrefil";
    repo = pname;
    rev = "59d5b6b6d7206a4a37096e04611ec3f047808292";
    hash = "sha256-zKJ8wuTfX57ESKCoZePJ/EjchPHAdcXGJ9o/RC89i+0=";
  };

  cargoHash = "sha256-cIHgsV6bwWWKjtFHswp641R3r5WugYW8T4xvTS2cZ1Q=";

  patches = [
    (fetchpatch {
      name = "ignore-busy-devices.patch";
      url = "https://github.com/htrefil/rkvm/commit/39d3a2ecea9deb78ec05c33bd280893aa40039ae.patch";
      hash = "sha256-M4OaR7YF8pjwFyJ95dX4E/MkqNKjUh7WGCzY1osJm3o=";
    })
  ];

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
