@echo off

set save_dir="E:\msc\singles\"
if not exist %save_dir% mkdir %save_dir%
pushd %save_dir%

if "%*" == "" goto usage

set year=%date:~6,4%
if not exist %year% mkdir %year%
pushd %year%

yt-dlp --ffmpeg-location "D:\ffmpeg-yt-dlp\bin" --embed-metadata -o "%%(uploader)s - %%(title)s.%%(ext)s" "%*"

popd
goto end

:usage
echo usage: scdl url

:end
popd

