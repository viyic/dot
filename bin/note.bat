@echo off

set save_dir="E:\rtrd\notes\"
if not exist %save_dir% mkdir %save_dir%
pushd %save_dir%

if "%*" neq "" goto args

set year=%date:~6,4%
if not exist %year% mkdir %year%
pushd %year%

set month=%date:~3,2%
start notepad "%month%.txt"

popd
goto end

:args
start notepad "%*.txt"

:end
popd
