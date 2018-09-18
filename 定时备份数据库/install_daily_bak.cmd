
@echo off
::------------------------------------用户配置------------------------------------------ 
set PATH_BAT=.\gamedb_daily_bak.bat
::------------------------------------用户配置------------------------------------------ 

::备份文件名 gamedb_daily_bak.bat 每天04:59开始
SCHTASKS /create /tn dailybak /tr %~dp0%PATH_BAT% /sc daily /ST 04:40 /RL HIGHEST
::每3小时备份一次
::SCHTASKS /create /tn dailybak /tr %~dp0gamedb_daily_bak.bat /sc hourly /mo 3 /ST 04:40 /ru System

pause
