@echo off
set filename[0]=1-1-1-1
set filename[1]=1-5-1-1
set filename[2]=1-11-1-1
set filename[3]=1-21-1-1
set filename[4]=1-22-1-1
set filename[5]=1-23-1-1
set filename[6]=1-26-1-1
set filename[7]=1-27-1-1
set filename[8]=1-28-1-1
set filename[9]=1-29-1-1
set filename[10]=3-2-1-1
set filename[11]=3-3-1-1
set filename[12]=3-6-1-1
set filename[13]=3-7-1-1
set filename[14]=3-8-1-1
set filename[15]=3-9-1-1

set index=0
:LoopStart
if not defined filename[%index%] (goto :End)
set doc_name=null
for /F "delims== tokens=1,2" %%i in ('set filename[%index%]') do (
        set doc_name=%%j
        )
if exist %doc_name% (
		xcopy /ysfi .\server C:\server\\%doc_name%\server

		net stop "SanGuo Authserver %doc_name%"
		xcopy /ysfi .\authserver C:\server\\%doc_name%\authserver
		net start "SanGuo Authserver %doc_name%"

		xcopy /ysfi .\logserver C:\server\\%doc_name%\logserver
		)

set /a index=index+1
goto :LoopStart
:End
::ren .\server.* .\server_%date%.*
::ren .\configs  .\configs_%date%.*
echo sucessful!
pause
