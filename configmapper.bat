
set CONFIGDIR=%HOMEPATH%\Documents\dev\config

MKLINK /D %HOMEPATH%\vimfiles %CONFIGDIR%\dot\vim
MKLINK %HOMEPATH%\_vimrc %CONFIGDIR%\dot\vimrc

MKLINK %HOMEPATH%\.gitconfig %CONFIGDIR%\xdg\git\config
MKLINK %HOMEPATH%\Documents\.Rprofile %CONFIGDIR%\dot\Rprofile

MKLINK %APPDATA%\stack\stack.yaml %CONFIGDIR%\xdg\stack\stack.yaml
MKLINK %HOMEPATH%\ghc\ghci.conf %CONFIGDIR%\dot\ghc\ghci.conf
