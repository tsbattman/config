{ lib
, python3
}: let
  youtube-dl = python3.pkgs.callPackage ./python-package.nix {};
in python3.pkgs.toPythonApplication youtube-dl
