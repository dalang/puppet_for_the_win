@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
ECHO.This version of Ruby has not been built with support for Windows 95/98/Me.
GOTO :EOF

:WinNT
REM THIS WILL SET THE PATH GLOBALLY
REM OTHER BATCH FILES SHOULD PROBABLY USE SETLOCAL
REM to preserve the build system environment
SETLOCAL
SET OLDPATH=%PATH%
REM Windows SDK (signtool.exe)
SET PATH=%~dp0sys\windows_sdk\Bin;%PATH%
REM Windows Installer XML Tools
SET PATH=%~dp0sys\wix\bin;%PATH%
REM Git version control tools
SET PATH=%~dp0sys\git\bin;%PATH%
REM Ruby itself
SET PATH=%~dp0sys\ruby\bin;%PATH%
REM Miscellaneous tools like 7zip
SET PATH=%~dp0sys\misc\bin;%PATH%

cd "%~dp0"
@"%~dp0sys\ruby\bin\ruby.exe" -S rake bootstrap %*
cd src
cd puppet_for_the_win
@"%~dp0sys\ruby\bin\ruby.exe" -S rake clean %*
@"%~dp0sys\ruby\bin\ruby.exe" -S rake windows:clone %*
@"%~dp0sys\ruby\bin\ruby.exe" -S rake windows:checkout[refs/tags/2.7.12,refs/tags/1.6.6] %*
@"%~dp0sys\ruby\bin\ruby.exe" -S rake windows:build %1 %*
