@echo off
reg add hkcu\Console /v QuickEdit /t REG_DWORD /d 0 /f
pause
