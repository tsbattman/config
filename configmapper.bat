
set CONFIGDIR=%HOMEPATH%\Documents\dev\config

MKLINK /D %HOMEPATH%\vimfiles %CONFIGDIR%\dot\vim
MKLINK %HOMEPATH%\_vimrc %CONFIGDIR%\dot\vimrc

MKLINK %HOMEPATH%\.gitconfig %CONFIGDIR%\xdg\git\config
MKLINK %HOMEPATH%\Documents\.Rprofile %CONFIGDIR%\dot\Rprofile

MKLINK %APPDATA%\stack\config.yaml %CONFIGDIR%\dot\stack\config.yaml
MKLINK %APPDATA%\ghc\ghci.conf %CONFIGDIR%\dot\ghc\ghci.conf

COPY %CONFIGDIR%\etc\hosts %SystemRoot%\system32\drivers\etc\hosts
