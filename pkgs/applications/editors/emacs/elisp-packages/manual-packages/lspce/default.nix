{
  lib,
  callPackage,
  f,
  lspce,
  markdown-mode,
  melpaBuild,
  yasnippet,
}:

let
  lspce-module = callPackage ./module.nix { };
  self = melpaBuild {
    pname = "lspce";
    inherit (lspce-module) version src meta;

    packageRequires = [
      f
      lspce-module
      markdown-mode
      yasnippet
    ];

    passthru = {
      inherit lspce-module;
    };
  };
in
self
