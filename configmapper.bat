
set CONFIGDIR=%HOMEPATH%\Documents\dev\config

MKLINK /D %HOMEPATH%\vimfiles %CONFIGDIR%\dot\vim
MKLINK %HOMEPATH%\_vimrc %CONFIGDIR%\dot\vimrc

MKLINK %HOMEPATH%\.gitconfig %CONFIGDIR%\xdg\git\config
MKLINK %HOMEPATH%\Documents\.Rprofile %CONFIGDIR%\dot\Rprofile

MKLINK %APPDATA%\stack\config.yaml %CONFIGDIR%\dot\stack\config.yaml
MKLINK %APPDATA%\ghc\ghci.conf %CONFIGDIR%\dot\ghc\ghci.conf

REM In widonws, gpg-agent.conf should include "enable-putty-support" and
REM GIT_SSH env variable is set to plink (program files/putty/plink.exe)
REM In powershell, $env:GIT_SSH = "C:\Program Files (x86)\putty\plink.exe"
REM or $env:GIT_SSH = "c:\ProgramData\chocolately\bin\plink.exe"
MKLINK %APPDATA%\gnupg\gpg-agent.conf %CONFIGDIR%\dot\gnupg\gpg-agent.conf

COPY %CONFIGDIR%\etc\hosts %SystemRoot%\system32\drivers\etc\hosts
