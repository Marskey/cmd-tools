
set filename[0]=D:\server\logserver\logserver_1_1
set filename[1]=D:\server\logserver\logserver_1_2
set filename[2]=D:\server\logserver\logserver_1_3
set filename[3]=D:\server\logserver\logserver_1_4
set filename[4]=D:\server\logserver\logserver_1_5
set filename[5]=D:\server\logserver\logserver_1_6
set filename[6]=D:\server\logserver\logserver_1_7
set filename[7]=D:\server\logserver\logserver_1_8
set filename[8]=D:\server\logserver\logserver_1_9
set filename[9]=D:\server\logserver\logserver_1_10
set filename[10]=D:\server\logserver\logserver_2_1
set filename[11]=D:\server\logserver\logserver_2_2
set filename[12]=D:\server\logserver\logserver_2_3
set filename[13]=D:\server\logserver\logserver_2_4
set filename[14]=D:\server\logserver\logserver_2_5
set filename[15]=D:\server\logserver\logserver_2_6
set filename[16]=D:\server\logserver\logserver_2_7
set filename[17]=D:\server\logserver\logserver_2_8
set filename[18]=D:\server\logserver\logserver_2_9
set filename[19]=D:\server\logserver\logserver_2_10

set index=0
:LoopStart
if not defined filename[%index%] (goto :End)
set cur_path=null
for /F "delims== tokens=1,2" %%i in ('set filename[%index%]') do (
        set cur_path=%%j
        )
if exist %cur_path% (
		start %cur_path%\logserver.exe -i
		)

set /a index=index+1
goto :LoopStart
:End
echo sucessful!
pause
