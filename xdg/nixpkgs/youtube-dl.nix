{ lib
, fetchFromGitHub
, python3
, setuptools
}:
python3.pkgs.buildPythonApplication rec {
  pname = "youtube-dl";
  version = "c5098961b04ce83f4615f2a846c84f803b072639";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "ytdl-org";
    repo = "youtube-dl";
    rev = version;
    hash = "sha256-bR3ns7mnavRXeZazAIuF8FmUXeWSiB7+zdtBpSKTtiw";
  };

  build-system = [ setuptools ];

  doCheck= false;

  meta = {
    description = "YouTube downloader";
    mainProgram = "youtube-dl";
    homepage = "https://github.com/ytdl-ord/YouTube-dl";
    platforms = with lib.platforms; darwin ++ linux;
  };
}
