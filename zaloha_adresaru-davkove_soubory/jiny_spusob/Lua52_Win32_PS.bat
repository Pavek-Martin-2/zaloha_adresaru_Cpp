@echo off
title Lua52_Win32.bat
:: tady menit title

for /f "delims=" %%a in ('powershell.exe -NoProfile -Command "$x = [string] $PSVersionTable.PSVersion; echo $x.Substring(0,3)"') do set "verze=%%a"

if %verze% NEQ 5.1 (
:: REM NEQ - not equal
echo mate jinou verzi PowerShell nezli 5.1
echo konec programu
sleep 5
goto end
)

set "ZDROJ=C:\Users\DELL\Documents\Lua52_Win32"
set "SULFIX=-Lua52_Win32.zip"
set "CIL_SLOZKA=C:\Users\DELL\Documents\zaloha\ruzne"
:: tady editovat 3 radky

for /f "delims=" %%a in ('powershell.exe -NoProfile -Command "Get-Date -Format 'dd_MM_yyyy-HH_mm_ss'"') do set "DATUM=%%a"

set "VYSTUP=%CIL_SLOZKA%\%DATUM%%SULFIX%"
echo %DATUM%%SULFIX%
sleep 3

zip -r -9 -S "%VYSTUP%" "%ZDROJ%" && unzip -t "%VYSTUP%" || pause
sleep 10

:end


