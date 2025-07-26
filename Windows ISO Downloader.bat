@echo off
:: Windows ISO Downloader
:: Requires cURL for downloads

:: Config
setlocal enabledelayedexpansion
color 1f
set "ver=2.03"
title Windows ISO Downloader %ver%

:: Check if cURL is available
where curl >nul 2>nul || (
    echo ERROR: cURL is not installed or not in PATH
    echo Please download cURL from https://curl.se/windows/
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b
)

:: Main Menu
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
set /p "ans=   Enter your version: "

if "%ans%"=="0" goto :0
if "%ans%"=="1" goto :1
if "%ans%"=="2" goto :2
if "%ans%"=="3" goto :3
if "%ans%"=="4" goto :4
if "%ans%"=="5" goto :5
if "%ans%"=="6" goto :6

echo Invalid selection. Please try again.
pause
goto :start

:0
cls
echo Are you sure you want to exit? (Y/N):
set /p "confirm="
if /i "%confirm%"=="Y" exit
goto :start

:: Windows XP Menu
:1
cls
echo ================================
echo    Windows XP ISO Downloader
echo ================================
echo.
echo Please choose an architecture.
echo.
echo [1] x86
echo [2] x64
echo.
echo [0] Back to Main Menu


:2
:3
:4
:5
:6
cls
echo This version is not yet implemented.
pause
goto :start