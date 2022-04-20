@echo off
setlocal enableextensions
pushd %~dp0

set game_name="ReadyOrNot"
set game_name=%game_name:"=%
set game_folder_path="../../../%game_name%/"

set mod_name="LocalizationRU"
set mod_name=%mod_name:"=%
set mod_folder_path="../../../%mod_name%"

if "%mod_name%"=="" goto mod_name_is_null
if not exist "%mod_folder_path%" goto check_mod_folder

echo Packing folder %mod_folder_path% for %game_name% game
echo %game_folder_path% >filelist.txt

if exist "%game_folder_path%" (
    echo Cleanup %game_folder_path% folder
    cd /d %game_folder_path%
    for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
)

cd %~dp0
echo Starting to copy files from %mod_folder_path% to %game_folder_path%
xcopy /s /I %mod_folder_path% %game_folder_path%

echo Calling UnrealPak...
.\UnrealPak.exe "ModPaks/pakchunk99-Mods_%mod_name%_P.pak" -create=filelist.txt -compress -multiprocess

popd
pause
goto :EOF

:mod_name_is_null
echo Mod name is null!
pause
goto :EOF

:check_mod_folder
echo Mod folder is not exist!
pause
goto :EOF
