{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}: buildPythonPackage rec {
  pname = "youtube-dl";
  version = "5975d7bb96095fae7c35e7cfcd819255a5b57087";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ytdl-org";
    repo = pname;
    rev = version;
    hash = "sha256-mQX9lN6LVXDIdzcC08MH/y99g/6jG5k4GoVsdSr5jwc=";
  };

  build-system = [ setuptools ];

  meta = {
    description = "YouTube downloader";
    mainProgram = "youtube-dl";
    homepage = "https://github.com/ytdl-ord/YouTube-dl";
    platforms = with lib.platforms; darwin ++ linux;
  };
}
