{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
}: buildPythonPackage rec {
  pname = "youtube-dl";
  version = "c5098961b04ce83f4615f2a846c84f803b072639";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ytdl-org";
    repo = pname;
    rev = version;
    hash = "sha256-bR3ns7mnavRXeZazAIuF8FmUXeWSiB7+zdtBpSKTtiw";
  };

  build-system = [ setuptools ];

  meta = {
    description = "YouTube downloader";
    mainProgram = "youtube-dl";
    homepage = "https://github.com/ytdl-ord/YouTube-dl";
    platforms = with lib.platforms; darwin ++ linux;
  };
}
