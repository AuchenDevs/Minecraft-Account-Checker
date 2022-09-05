@echo off

setlocal EnableDelayedExpansion
echo Alts encontradas:
if defined json_lookup (
    set json_lookup=
)
set cn=0
for /f "usebackqdelims=" %%A in ("%appdata%\.minecraft\usercache.json") do (
    set "json_lookup=%%A"
    goto :LOOP
)
:LOOP
if not defined json_lookup (
    goto :END
)
echo !"!!json_lookup!!"!| >nul find """name"":""" || (
    goto :END
)
set "json_lookup=!json_lookup:*"name":"=!"
if "!json_lookup!"=="" (
    goto :END
)
for /f delims^=^" %%B in ("!json_lookup!") do (
    set "username_json_lookup=%%B"
)
echo !username_json_lookup!
goto :LOOP

:END
pause
exit /b