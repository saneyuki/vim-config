@echo off

rem
rem we need to run this bat as root.
rem

rem remove old symbolic links
rm %HOME%\.vimrc
rm %HOME%\.gvimrc
rd %HOME%\vimfiles

rem create new symbolic links
mklink %HOME%\.vimrc  %CD%\vimrc
mklink %HOME%\.gvimrc  %CD%\gvimrc
mklink /D %HOME%\vimfiles  %CD%\vimfiles

