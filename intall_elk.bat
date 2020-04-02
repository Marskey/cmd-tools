
@echo off
cd /d %~dp0

REM ***************** Config **********************
set LogStashConf=star2.conf
set MyJRE64Path="C:\Program Files\java\jre"
REM ***********************************************


Rem 创建文件路径
set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
echo %TempFile_Name%
 
Rem 写入文件
( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
 
Rem 判断写入是否成功
if not exist %TempFile_Name% (
    echo Please use it by click 'Run As Administrator.'
    pause
    goto eof
)
 
Rem 删除临时文件
del %TempFile_Name% 1>nul 2>nul

IF EXIST %MyJRE64Path%\bin\java.exe goto start
echo **********************************************
echo.
echo Going to install jre.
echo.
echo Continue by press any key, otherwise click close button.
echo.
echo **********************************************
pause
echo.
echo Installing jre...please wait..
echo.
start /WAIT jre-8u201-windows-x64.exe /s INSTALLDIR=%MyJRE64Path%
echo jre Installed

setx JAVA_HOME %MyJRE64Path% -m
REM setx PATH %PATH%;%JAVA_HOME%\bin;
REM setx CLASSPATH .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
echo Java System environment variables registered.

:start
REM 安装启动 elasticsearch 服务
pushd elasticsearch*\bin
    sc query "elasticsearch-service-x64" > nul
    if errorlevel 1060 goto noexist
    goto exist
    :noexist
    start /wait cmd /c elasticsearch-service.bat install

    :exist
    start /wait cmd /c elasticsearch-service.bat start
popd

pause

REM 启动 logstash 服务
pushd logstash*\bin
    start logstash.bat -f %LogStashConf%
popd

REM 启动 kibana 服务
pushd kibana*\bin
    start kibana.bat
popd
