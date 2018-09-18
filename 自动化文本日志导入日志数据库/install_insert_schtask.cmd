@echo off

::------------------------------------用户配置------------------------------------------ 
set PATH_BAT=.\start_all_insert.cmd
set TASK_NAME=hourlyInsert
::------------------------------------用户配置------------------------------------------ 
::
SCHTASKS /create /tn %TASK_NAME% /tr %~dp0%PATH_BAT% /sc hourly /ST 00:00 /RL HIGHEST
pause
