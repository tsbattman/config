[
  (self: super: {
    youtube-dl = super.callPackage ./youtube-dl.nix {
      inherit (self) lib fetchFromGitHub python3;
      setuptools = self.python3.pkgs.setuptools;
    };
  })
]
