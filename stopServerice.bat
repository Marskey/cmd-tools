@echo off
set filename[0]=5-1-1-1
set filename[1]=5-11-1-1
set filename[2]=5-12-1-1
set filename[3]=5-13-1-1
set filename[4]=5-14-1-1
set filename[5]=5-15-1-1
set filename[6]=5-16-1-1
set filename[7]=5-17-1-1
set filename[8]=5-18-1-1
set filename[9]=5-19-1-1
set filename[10]=5-20-1-1
set filename[11]=5-21-1-1
set filename[12]=5-22-1-1
set filename[13]=5-23-1-1
set filename[14]=5-24-1-1
set filename[15]=5-25-1-1
set filename[16]=5-26-1-1
set filename[17]=5-27-1-1
set filename[18]=5-28-1-1
set filename[19]=5-29-1-1
set filename[20]=5-50-1-1


set index=0
:LoopStart
if not defined filename[%index%] (goto :End)
set cur_path=null
for /F "delims== tokens=1,2" %%i in ('set filename[%index%]') do (
        set cur_path=%%j
        )
if exist %cur_path% (
		net stop "SanGuo Authserver %cur_path%"
		)

set /a index=index+1
goto :LoopStart
:End
::ren .\server.* .\server_%date%.*
::ren .\configs  .\configs_%date%.*
echo sucessful!
pause
