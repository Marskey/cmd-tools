@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
::------------------------------------用户配置------------------------------------------ 
set DIR_LOG=.\log\cylog
set DIR_INSERT=.\lostdata_sql
set PWD_DB=Inj@2011
set PATH_CONFIG_INI=.\config.ini
::------------------------------------用户配置------------------------------------------ 

if not exist %DIR_INSERT% ( mkdir %DIR_INSERT% )

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x

set year=%MyDate:~,4%
set month=%MyDate:~4,2%
set day=%MyDate:~6,2%
set hour=%MyDate:~8,2%
set min=%MyDate:~10,2%
set sec=%MyDate:~12,2%

set ExeYmd=%year%_%month%_%day%T%hour%_%min%_%sec%

:: take a hour ago
SET /A hour-=1
IF %hour% LSS 0 SET /A hour+=24 & SET /A day-=1
IF %day% LSS 1 (
		SET /A month-=1
		IF !month! LSS 1 SET /A month+=12 & SET /A year-=1
		FOR %%m IN (1 3 5 7 8 10 12) DO IF %%m == !month! SET /A day+=31
		FOR %%m IN (4 6 9 11) DO IF %%m == !month! SET /A day+=30
		IF !month! == 2 (
			SET /A day+=28
			SET /A y4=!year! %% 4
			IF !y4! == 0 (
				SET /A y400=!year! %% 400
				IF !y400! == 0 (
					SET /A day+=1
					) ELSE (
						SET /A y100=!year! %% 100
						IF NOT !y100! == 0 SET /A day+=1
						)
				)
			)
		)

set ExeFileTime=%year%-%month%-%day%-%hour%

copy %DIR_LOG%\*.log.%ExeFileTime% $

for /F "delims= tokens=1,2" %%i in ($) do ( echo\%%j >> %DIR_INSERT%\%ExeYmd%.sql )

set logdbname=
for /f "delims=" %%a in ('call readini.cmd %PATH_CONFIG_INI% log_db_info db') do (
    set logdbname=%%a
)

echo ^>Importing to %logdbname%...
mysql -uroot -p%PWD_DB% -D%logdbname% < %DIR_INSERT%\%ExeYmd%.sql
echo ^>Complete

del $
pause
