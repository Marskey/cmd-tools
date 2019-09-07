@echo off

rem 启动器说明
rem 首先创建启动列表，命名例如 rank
rem =====↓=====文件内容: =====
rem GROUP-
rem ActRankServer
rem OnlineBattleRankServer
rem PowerRankServer
rem -GROUP
rem RankServer
rem =====↑=====文件内容: =====
rem 从GROUP- 开始 到 -GROUP 为止的全部以一个cmd窗口为输出窗口
rem 其余的都以新的窗口打开

setlocal enabledelayedexpansion
set isServiceExists=0

set SERVER_DIR=Source\bin\debug\bin
set DEFAULT_START_LIST=base

echo ## Start servers ##
cd %~dp0

if not [%~1]==[] (
        set INPUT_SERVER_DIR=%~1
        )

if defined INPUT_SERVER_DIR (
        set SERVER_DIR=%INPUT_SERVER_DIR%
        )

set SERVER_DIR=%SERVER_DIR:/=\%

echo Server Dir=%SERVER_DIR%
set DIR=%DEFAULT_START_LIST%
set /p DIR=Input Server List(DEFAULT: base):

if /i %DIR%=="all" (
        set DIR='dir /b /o:n /ad "%SERVER_DIR%"'
        )

set GROUP=0
for /f %%i in (%DIR%) do (
        if !GROUP!==0 (
            echo %%i | findstr "^GROUP-" > nul
        ) else (
            echo %%i | findstr "^-GROUP" > nul
            )
        call :startService !errorlevel! %%i
    )
@ping 127.0.0.1 -n 3 >nul
title %GROUP_NAME%

pause

:checkServiceExists
tasklist /FO CSV /FI "IMAGENAME eq %~1.exe" 2>NUL | find /N "%~1.exe">NUL
set isServiceExists=%ERRORLEVEL%
goto :eof

:startService
if !GROUP!==0 (
        if %1==0 (
            set GROUP=1
            goto CONTINUE
            )
) else (
    if %1==0 (
        set GROUP=0
        goto CONTINUE
        )
    )
call :checkServiceExists %2
if not "!isServiceExists!"=="0" (
        echo %2
        pushd %SERVER_DIR%\%2

        if !GROUP!==0 (
            start /MIN %2.exe
            ) else (
                start /b /min %2.exe
                if not defined GROUP_NAME (
                    set GROUP_NAME=path:%~dp0 Group= %2
                    ) else (
                        set GROUP_NAME=!GROUP_NAME!, %2
                        )
                )
        popd
        )
:CONTINUE
rem
