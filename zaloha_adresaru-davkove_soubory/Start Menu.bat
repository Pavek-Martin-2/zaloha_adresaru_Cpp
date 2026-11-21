@echo off
title Start Menu.bat
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

:: Slozeni vysledne promenne (napr. 19112026_092105)
set "DATUM_CAS=%DEN%_%MESIC%_%ROK%-%HODINA%_%MINUTA%_%VTERINA%"

set "archiv=%DATUM_CAS%-Start Menu.zip"
echo %archiv%
sleep 3

zip -r -9 -S "C:\Users\DELL\Documents\zaloha\ruzne\%archiv%" "C:\ProgramData\Microsoft\Windows\Start Menu" && unzip -t "C:\Users\DELL\Documents\zaloha\ruzne\%archiv%" || pause

sleep 10

