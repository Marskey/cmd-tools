
@echo off
::------------------------------------用户配置------------------------------------------ 
::数据库密码
set dbpwd=Inj@2011
::备份的数据库名字前缀 例如要备份 sggamedb_1, sggamedb_2, 写成 '%%gamedb_%%'
set dbname='%%gamedb%%'
::是否删除旧的备份文件 1删除 0不删除
set DelOldBak=1
::删除x天前的备份 填0无效
set DelDaysBefore=7
::备份的文件夹名字
set bakfoldername=gamedb_bak
::------------------------------------用户配置------------------------------------------ 

::------------------------------------业务逻辑------------------------------------------ 
setlocal enabledelayedexpansion
cd /d %~dp0

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set Ymd=%MyDate:~,4%_%MyDate:~4,2%_%MyDate:~6,2%T%MyDate:~8,2%_%MyDate:~10,2%_%MyDate:~12,2%

set get_db_name="SELECT distinct table_schema FROM information_schema.tables WHERE table_schema LIKE %dbname%"
mysql -uroot -p%dbpwd% -e%get_db_name% > $

if not exist %bakfoldername% (mkdir %bakfoldername%)

for /F "delims== tokens=1" %%i in ($) do (
        set cur=%%i
		if !cur! neq table_schema (
			echo backing up %bakfoldername%/!cur!_!Ymd!...
			mysqldump -uroot -p%dbpwd% "!cur!" > %bakfoldername%\!cur!_!Ymd!.sql
			)
		)
echo backup all done!
echo compressing...
	7z a -y %bakfoldername%\%bakfoldername%_%Ymd%.zip %bakfoldername%\*.sql

del %bakfoldername%\*.sql

if %DelOldBak% equ 1 if %DelDaysBefore% neq 0 (
	echo deleting %DelDaysBefore% days before bak files.
	forfiles /p "." /s /m %bakfoldername%*T*.zip /d -%DelDaysBefore% /c "cmd /c del @path"  
)

echo All done!
del $
::------------------------------------业务逻辑------------------------------------------ 
@echo on
