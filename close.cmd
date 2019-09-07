@echo off
setlocal enabledelayedexpansion
set isServiceExists=0
cd %~dp0

if not [%~1]==[] (
        set INPUT=%~1
        )

if not defined INPUT (
        goto no
        )

choice /t 3 /d:y /m "Want to close server: %INPUT% (3s for Y)"

IF ERRORLEVEL 2 GOTO no
IF ERRORLEVEL 1 GOTO yes

:no
set /p INPUT=Input server:

:yes
 call :checkServiceExists %INPUT%
 if "!isServiceExists!"=="0" (
         pushd Source\bin\debug\bin\%INPUT%
         Taskkill /IM %INPUT%.exe /F
         popd
         )

 pause

:checkServiceExists
tasklist /FO CSV /FI "IMAGENAME eq %~1.exe" 2>NUL | find /N "%~1.exe">NUL
set isServiceExists=%ERRORLEVEL%
goto :eof
