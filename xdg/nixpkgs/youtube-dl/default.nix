{ lib
, python
}: let
  youtube-dl = python.pkgs.callPackage ./python-package.nix {};
in python.pkgs.toPythonApplication youtube-dl
