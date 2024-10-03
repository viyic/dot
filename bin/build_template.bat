@echo off
:: IF NOT EXIST build mkdir build
set CCPP=main.cpp
set CLIB=

set CFLAGS=-MD -nologo -Zi -Od -WX -W3 -FC
set LFLAGS=
::/link /LIBPATH:..\lib
set CINC=
::-I "..\include"

:: pushd build
cl %CFLAGS% %CINC% %CCPP% %CLIB% %LFLAGS%
:: popd
