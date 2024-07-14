{
  lib,
  callPackage,
  emacsPackages,
  fetchFromGitHub,
  rustPlatform,
}:

let
  self = rustPlatform.buildRustPackage {
    pname = "lspce-module";
    version = "1.1.0-unstable-2024-07-13";

    src = fetchFromGitHub {
      owner = "zbelial";
      repo = "lspce";
      rev = "01b77a4f544a912409857083842db51a20bfdbf3";
      hash = "sha256-oew5EujNYGjk/agBw3ECAVe7GZl8rw/4M5t32JM+1T8=";
    };

    cargoHash = "sha256-YLcSaFHsm/Iw7Q3y/YkfdbYKUPW0DRmaZnZ1A9vKR14=";

    checkFlags = [
      # flaky test
      "--skip=msg::tests::serialize_request_with_null_params"
    ];

    strictDeps = true;

    # Move all lib/ files to share/emacs/site-lisp
    postInstall = ''
      mkdir -p $out/share/emacs/site-lisp
      for f in $out/lib/*; do
        mv $f $out/share/emacs/site-lisp/lspce-module.''${f##*.}
      done
      rmdir $out/lib
    '';

    meta = {
      homepage = "https://github.com/zbelial/lspce";
      description = "LSP Client for Emacs implemented as a module using rust";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [ AndersonTorres ];
    };
  };
in
self
