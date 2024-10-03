@echo off
prompt $E[92m$P$E[90m$E[m$S$E]9;12$E\$_$G$S

doskey pwd  = cd
doskey cd   = cd /d $*

doskey n = nvy $*

doskey dir = dir /o:g $*
:: /w
doskey vcvars = "D:\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

doskey reload  = D:\bin\initcmd.bat
doskey init  = D:\Nvy\Nvy.exe D:\bin\initcmd.bat

doskey help = echo copy, move, remove, rmdir, type ^& echo initcpp: vcvars ^& echo reload, init: reload and edit init

doskey flask-on  = venv\Scripts\activate
doskey flask-off = venv\Scripts\deactivate

doskey ar = php artisan $*

doskey msc = E:\lambda\odin\msc\run\msc.exe