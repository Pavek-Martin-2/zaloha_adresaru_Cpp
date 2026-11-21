@echo off
title tools.bat
setlocal

:: Rozdeleni %DATE% (odstrani pripadny nazev dne a tecky)
for /f "tokens=1-4 delims=. " %%a in ("%DATE%") do (
    if "%%d"=="" (
        set "DEN=%%a"
        set "MESIC=%%b"
        set "ROK=%%c"
    ) else (
        set "DEN=%%b"
        set "MESIC=%%c"
        set "ROK=%%d"
    )
)

:: Pokud je %TIME% napriklad " 9:23:05,12", zmeni se na "09:23:05,12"
set "CAS=%TIME: =0%"

:: Rozdeleni na jednotlive casti
for /f "tokens=1-3 delims=:," %%a in ("%CAS%") do (
    set "HODINA=%%a"
    set "MINUTA=%%b"
    set "VTERINA=%%c"
)

REM echo Hodina s nulou: %HODINA%
REM echo Cely cas: %HODINA%_%MINUTA%_%VTERINA%

:: Slozeni vysledne promenne (napr. 19112026_092105)
set "DATUM_CAS=%DEN%_%MESIC%_%ROK%-%HODINA%_%MINUTA%_%VTERINA%"

REM echo %DATUM_CAS%

set "archiv=%DATUM_CAS%-tools.zip"
echo %archiv%
sleep 3

zip -r -9 -S "C:\Users\DELL\Documents\zaloha\ruzne\%archiv%" "C:\tools" && unzip -t "C:\Users\DELL\Documents\zaloha\ruzne\%archiv%" || pause

sleep 10
