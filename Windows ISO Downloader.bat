@echo off
:: Config
	color 1f
	set "ver=2.01"
	echo.

:: Title
:start
cls
echo.
echo =================================
echo   Windows ISO Downloader %ver%
echo =================================
echo.
echo   Choose a version:
echo   -----------------
echo.
echo   [1] Windows XP
echo   [2] Windows Vista
echo   [3] Windows 7
echo   [4] Windows 8
echo   [5] Windows 10
echo   [6] Windows 11
echo.
echo   [0] Exit
echo.
echo =================================
set /p ans=   Enter your version:

		if "%ans%"=="0" goto :0
		if "%ans%"=="1" goto :1
		if "%ans%"=="2" goto :2
		if "%ans%"=="3" goto :3
		if "%ans%"=="4" goto :4
		if "%ans%"=="5" goto :5
		if "%ans%"=="6" goto :6

	echo Invalid character.
	pause
	goto :start

:0
cls
echo Are you sure you want to exit? (Y/N):
set /p confirm=
if /i "%confirm%"=="Y" exit
goto :start