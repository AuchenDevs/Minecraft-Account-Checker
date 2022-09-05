@echo off

setlocal EnableDelayedExpansion
echo Alts encontradas:>>"%logdir%"
set logdir="%APPDATA%\AuchenSSTool\SS_File.txt"
if defined json_lookup (
    set json_lookup=
)
set cn=0
for /f "usebackqdelims=" %%A in ("%appdata%\.minecraft\usercache.json") do (
    set "json_lookup=%%A"
    goto :McAccLoop
)
:McAccLoop
set premium=na
if not defined json_lookup (
    goto :McAccEnd
)
echo !"!!json_lookup!!"!| >nul find """name"":""" || (
    goto :McAccEnd
)
set "json_lookup=!json_lookup:*"name":"=!"
if "!json_lookup!"=="" (
    goto :McAccEnd
)
for /f delims^=^" %%B in ("!json_lookup!") do (
    set "username_json_lookup=%%B"
)
curl --insecure --silent -XGET https://api.mojang.com/users/profiles/minecraft/!username_json_lookup! | find /I "!username_json_lookup!" >%temp%\MinecraftPremiumChecker.tmp && set premium=yes
if "%premium%"=="na" (echo !username_json_lookup! - No premium>>"%logdir%") else (echo !username_json_lookup! - Premium>>"%logdir%")
goto :McAccLoop

:McAccEnd
SETLOCAL DisableDelayedExpansion
explorer.exe "%appdata%\AuchenSSTool"
exit /b