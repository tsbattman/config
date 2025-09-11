{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
}:
buildPythonPackage rec {
  pname = "youtube-dl";
  version = "a084c80f7bac9ae343075a97cc0fb2c1c96ade89";
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
