@echo off
set filename[0]=D:\server\authserver\authserver_1_1
set filename[1]=D:\server\authserver\authserver_1_2
set filename[2]=D:\server\authserver\authserver_1_3
set filename[3]=D:\server\authserver\authserver_1_4
set filename[4]=D:\server\authserver\authserver_1_5
set filename[5]=D:\server\authserver\authserver_1_6
set filename[6]=D:\server\authserver\authserver_1_7
set filename[7]=D:\server\authserver\authserver_1_8
set filename[8]=D:\server\authserver\authserver_1_9
set filename[9]=D:\server\authserver\authserver_1_10
set filename[10]=D:\server\authserver\authserver_2_1
set filename[11]=D:\server\authserver\authserver_2_2
set filename[12]=D:\server\authserver\authserver_2_3
set filename[13]=D:\server\authserver\authserver_2_4
set filename[14]=D:\server\authserver\authserver_2_5
set filename[15]=D:\server\authserver\authserver_2_6
set filename[16]=D:\server\authserver\authserver_2_7
set filename[17]=D:\server\authserver\authserver_2_8
set filename[18]=D:\server\authserver\authserver_2_9
set filename[19]=D:\server\authserver\authserver_2_10

set index=0
:LoopStart
if not defined filename[%index%] (goto :End)
set cur_path=null
for /F "delims== tokens=1,2" %%i in ('set filename[%index%]') do (
        set cur_path=%%j
        )
if exist %cur_path% (
		start %cur_path%\authserver.exe -i
		)

set /a index=index+1
goto :LoopStart
:End
echo sucessful!
pause
