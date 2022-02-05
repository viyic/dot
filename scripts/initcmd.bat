@echo off
prompt $E[92m$P$E[90m$E[m$S$E]9;12$E\$_$G$S

doskey pwd  = cd
doskey cd   = cd /d $*
doskey j    = cd /d "D:\programming\java"
doskey game = cd /d "D:\programming\c_cpp\game\"
:: doskey game = cd /d "D:\programming\java\software\gl"

doskey n = nvy $*

doskey jc  = javac $1.java $T java $1
REM doskey dir = dir /w $*
doskey dir = java -cp "D:\programming\java\software\mydir" MyDir $*
doskey initcpp = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
doskey mkdircpp = mkdir $1 $T copy D:\exec\build_template.bat $1\build.bat
doskey run = .\build\code

doskey rr  = D:\exec\initcmd.bat
doskey ei  = D:\Nvy\Nvy.exe D:\exec\initcmd.bat

doskey mycmd = echo j, game: D:\programming\ ^& echo jc: compile and run java ^& echo initcpp, mkdircpp: vcvars and make cpp dir ^& echo rr, ei: reload and edit init

:: cls
