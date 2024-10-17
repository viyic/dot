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

doskey gs = git status $*
doskey gc = git commit $*
doskey ga = git add $*
doskey gco = git checkout $*
doskey gd = git diff $*
doskey gdc = git diff --cached $*
doskey gl = git log --graph --pretty="tformat:%%C(always,yellow)%%h%%C(always,reset) %%C(always,green)%%ar%%C(always,reset) %%C(always,bold blue)%%an%%C(always,reset) %%C(always,red)%%d%%C(always,reset) %%s" $*

doskey msc = E:\lambda\odin\msc\run\msc.exe
