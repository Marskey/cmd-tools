@echo off 
set f=c:\aaa.txt 
set f2="c:\aaa.bak.txt" 
for /?>%f% 
if exist %f2% del %f2% 
for /f "tokens=* delims=％" %%l in (%f%) do ( 
 set line=%%l 
 set line=!line:FOR=F_O_R! 
 echo !line!>>%f2% 
 ) 
