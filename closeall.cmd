@echo off
setlocal enabledelayedexpansion
set isServiceExists=0

set SERVER_DIR=Source\bin\debug\bin
set DEFAULT_SERVER_LIST=all

echo ## Closing servers... ##
cd %~dp0

set DIR=%DEFAULT_SERVER_LIST%
set /p DIR=Input Server List(default: all):

if /i "%DIR%"=="all" (
        set DIR='dir /b /o:n /ad "%SERVER_DIR%"'
        )

for /f %%i in (%DIR%) do (
        call :checkServiceExists %%i
        if "!isServiceExists!"=="0" (
            pushd %SERVER_DIR%\%%i
            Taskkill /IM %%i.exe /F
            popd
        )
    )

REM pause

:checkServiceExists
tasklist /FO CSV /FI "IMAGENAME eq %~1.exe" 2>NUL | find /N "%~1.exe">NUL
set isServiceExists=%ERRORLEVEL%
goto :eof
