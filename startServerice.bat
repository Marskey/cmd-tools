@echo off
set filename[0]=1-1-1-1
set filename[1]=1-2-1-1
set filename[2]=1-3-1-1
set filename[3]=1-4-1-1
set filename[4]=1-5-1-1
set filename[5]=2-1-1-1
set filename[6]=2-2-1-1
set filename[7]=2-3-1-1
set filename[8]=2-4-1-1
set filename[9]=2-5-1-1
set filename[10]=3-1-1-1
set filename[11]=3-2-1-1
set filename[12]=3-3-1-1
set filename[13]=3-4-1-1
set filename[14]=3-5-1-1
set filename[15]=4-1-1-1
set filename[16]=4-2-1-1
set filename[17]=4-3-1-1
set filename[18]=4-4-1-1
set filename[19]=4-5-1-1


set index=0
:LoopStart
if not defined filename[%index%] (goto :End)
set cur_path=null
for /F "delims== tokens=1,2" %%i in ('set filename[%index%]') do (
        set cur_path=%%j
        )
if exist %cur_path% (
		net start "SanGuo Authserver %cur_path%"
		)

set /a index=index+1
goto :LoopStart
:End
::ren .\server.* .\server_%date%.*
::ren .\configs  .\configs_%date%.*
echo sucessful!
pause
