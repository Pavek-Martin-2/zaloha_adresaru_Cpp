cls
@echo off

set nazev_archivu=Lua52_Win32
REM nazev, to co bude za datumem v nazvu ( bez pripony )

set zapakuj_adresar=C:\Users\DELL\Documents\Lua52_Win32
REM kterej adresar se ma "zazipovat"


set zalohy=C:\Users\DELL\Documents\zaloha\ruzne\
REM tady zmenit cestu kam se budou ukladat archivy "zip" 
REM to se dala jenom jednou ( lomitko na konci ! )

set nazev_archivu=%nazev_archivu%.zip
title %nazev_archivu%

REM DATUM
set dat=%DATE%
set d=%dat:~0,2%
set m=%dat:~3,2%
set r=%dat:~6,4%

REM CAS
set tim=%TIME%
set hod_1=%tim:~0,1%
set tim=%TIME%

set hod_1=%tim:~0,1%

if "%hod_1%" EQU " " (
REM tady musi bejt to prvni v uvozovkach, jinak to nejde
set hod_2=0%tim:~1,1%
REM < 10:00 je napr. " 9.59 ..." mezera na zacatku
) else (
set hod_2=%tim:~0,2%
)

set min=%tim:~3,2%
set sec=%tim:~6,2%

set cas=%d%_%m%_%r%-%hod_2%_%min%_%sec%-
set archiv=%cas%%nazev_archivu%
echo %archiv%
sleep 3


REM test existence souboru "tar"
dir C:\windows\System32\tar.exe > nul
if errorlevel == 1 goto zipovat
REM tarovat
tar -acvf "%zalohy%%archiv%" "%zapakuj_adresar%" || pause
REM alternativni prikaz 'tar' soucasti Windows 10 od build 1803 a ve Windows 11
REM 'tar' bohuzel neumi provadet test vytvoreneho archivu
goto konec

:zipovat
REM test existence prikazu "zip" a "unzip" ( musej bejt oba )
zip > nul
if errorlevel == 1 goto chyba

unzip > nul
if errorlevel == 1 goto chyba_unzip

REM zipovat
zip -r -9 -S "%zalohy%%archiv%" "%zapakuj_adresar%" && unzip -t "%zalohy%%archiv%" || pause
goto konec

:chyba_unzip
REM "zip" je a chyby jen "unzip"
zip -r -9 -S "%zalohy%%archiv%" "%zapakuj_adresar%" || pause
goto konec

:chyba
echo NEBYL NENALEZEN ZADNY PROTEBNY ARCHIVATOR, ZALOHA NEPROBEHLA !

:konec
sleep 10
