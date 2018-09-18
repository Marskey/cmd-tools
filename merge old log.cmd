@echo off
chcp 65001
copy old\*.log.* $

echo processing...
for /F "tokens=1,2,* delims= " %%i in ($) do ( echo\%%k; >> .\old.sql )
echo done!
pause
del $

