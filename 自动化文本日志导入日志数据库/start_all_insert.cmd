@echo off
cd /d %~dp0
forfiles /p "." /s /m insert_into_db.cmd /c "cmd /c call @path"
