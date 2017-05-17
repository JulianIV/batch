@echo off
setlocal enableextensions EnableDelayedExpansion 
title RenameFiles
cd %cd%

rem check what user wants to do
:MAKECHOICE
cls
echo Current directory: %cd%
set /P choice="Change directory (y/n/quit)? "

if /I %choice%==y (
rem change directory
	set /P selectedDirectory="New directory: "
	if !selectedDirectory!==quit (
		goto END
	)
	echo !selectedDirectory!
	cd !selectedDirectory!
	goto RENAME
)
if /I %choice%==n (
rem use current directory 
	set "selectedDirectory=%cd%"
	echo Directory: !selectedDirectory!
	goto RENAME 
	)
if /I %choice%==quit (
	goto END
) else (
	goto MAKECHOICE
)

rem rename all files in selected directory
:RENAME	
echo %~dp0\renameFromFolder.bat 
set cnt=0
for %%A in ("%selectedDirectory%\*") do set /a cnt+=1
echo File count = %cnt%
set /P name="New name: "
if "%name%"=="quit" (
	goto END
)
set /A int=0
for %%I in ("%selectedDirectory%\*") do (
	if not "%%~nxI"=="%~nx0" (
		if !int!==0 (
			ren %%I %name%.* 
			set /A int += 1 
		) else ( 
			ren %%I %name%!int!.*
			set /A int += 1 
		)
	)
) 
echo Done!

:END
echo Exiting program...
timeout 3