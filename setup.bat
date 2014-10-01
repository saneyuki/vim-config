@echo off

rem
rem we need to run this bat as root.
rem

rem remove old symbolic links
rm %USERPROFILE%\.vimrc
rm %USERPROFILE%\.gvimrc
rd %USERPROFILE%\vimfiles

rem create new symbolic links
mklink %USERPROFILE%\.vimrc  %CD%\vimrc
mklink %USERPROFILE%\.gvimrc  %CD%\gvimrc
mklink /D %USERPROFILE%\vimfiles  %CD%\vimfiles

