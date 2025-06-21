@echo off
title Windows ISO Downloader by Kaverian
color 1f
mode con:cols=80 lines=30

:: Check if curl is available
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo curl is not installed or not in PATH!
    echo Please install curl from: https://curl.se/windows/
    pause
    exit /b
)

:: Get user's Downloads folder
for /f "tokens=2*" %%A in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}"') do set "downloads=%%B"
set "downloads=%downloads:\=\\%"
call set "downloads=%downloads%"

:main
cls
echo.
echo  ==============================
echo   WINDOWS ISO DOWNLOADER 1.7
echo  ==============================
echo.
echo  [1] Windows XP
echo  [2] Windows Vista
echo  [3] Windows 7
echo  [4] Windows 8.x
echo  [5] Windows 10
echo  [6] Windows 11
echo  [7] Exit
echo.
set /p choice="Select an option [1-7]: "

if "%choice%"=="1" goto xp
if "%choice%"=="2" goto vista
if "%choice%"=="3" goto win7
if "%choice%"=="4" goto win8
if "%choice%"=="5" goto win10
if "%choice%"=="6" goto win11
if "%choice%"=="7" exit
goto main

:xp
cls
echo.
echo  Windows XP ISO Download
echo  =======================
echo.

set "bitVer="
set /p bitVer="Choose architecture [32/64]: "
if /i "%bitVer%"=="32" (
    set "url=https://example.com/windows-xp-32.iso"
    set "iso=Windows_XP_32bit.iso"
) else if /i "%bitVer%"=="64" (
    set "url=https://example.com/windows-xp-64.iso"
    set "iso=Windows_XP_64bit.iso"
) else (
    echo Invalid option!
    pause
    goto main
)

set "downloadPath="
set /p downloadPath="Enter the full path to save the ISO (or press Enter to use Downloads folder): "
if "%downloadPath%"=="" set "downloadPath=%downloads%"
if not exist "%downloadPath%" mkdir "%downloadPath%"
set "output=%downloadPath%\%iso%"

goto download

:vista
cls
echo.
echo  Windows Vista ISO Download
echo  ==========================
echo.

:: Ask for edition first
echo Available editions:
echo [1] Ultimate
echo [2] Enterprise
echo [3] Professional
echo [4] Home Premium
echo [5] Home Basic
echo [6] Starter (32 Bit Only)
set /p ed="Select an edition [1-6]: "

if "%ed%"=="1" (
    set "edition=Ultimate"
) else if "%ed%"=="2" (
    set "edition=Enterprise"
) else if "%ed%"=="3" (
    set "edition=Professional"
) else if "%ed%"=="4" (
    set "edition=HomePremium"
) else if "%ed%"=="5" (
    set "edition=HomeBasic"
) else if "%ed%"=="6" (
    set "edition=Starter"
    set "bitVer=32"
    goto skipVistaArch
) else (
    echo Invalid selection!
    pause
    goto main
)

:askVistaArch
set "archChoice="
set /p archChoice="Choose architecture [1 = x86 / 2 = x64]: "
if "%archChoice%"=="1" (
    set "bitVer=32"
) else if "%archChoice%"=="2" (
    set "bitVer=64"
) else (
    echo Invalid architecture choice!
    pause
    goto askVistaArch
)

:skipVistaArch

echo.
echo Available versions:
echo [1] RTM
echo [2] SP1
echo [3] SP2
set /p ver="Select a version [1-3]: "

:: Set URLs based on edition, version, and architecture
if "%edition%"=="Ultimate" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/en_windows_vista_x86_dvd_x12-34293_202010/en_windows_vista_x86_dvd_x12-34293.iso"
        set "url64=https://archive.org/download/lrmcx-fre-en-dvd/LRMCxFRE_EN_DVD.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://archive.org/download/vistaultimatex86_64/FRMCXFRE_EN_DVD%28x64%29.ISO"
        set "url64=https://archive.org/download/en_windows_vista_with_service_pack_1_x64_dvd_x14-29595_202010/en_windows_vista_with_service_pack_1_x64_dvd_x14-29595.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/en_windows_vista_ultimate_sp2_x86_dvd/en_windows_vista_ultimate_sp2_x86_dvd.iso"
        set "url64=https://archive.org/download/windows-vista-ultimate-sp-2-x-64-fully-updated/Windows%20Vista%20Ultimate%20SP2%20x64%20Fully%20Updated.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
) else if "%edition%"=="Enterprise" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/WindowsVistaEnterpriseRTMX86/en_windows_vista_ee_x86_dvd_vl_x13-17271.iso"
        set "url64=https://archive.org/download/WinvistaEnterpriseRTMCollectionMUI/en_windows_vista_enterprise_x64_dvd_vl_x13-17316.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://archive.org/download/WindowsVistaEnterprisewithServicePack1X86/en_windows_vista_enterprise_with_service_pack_1_x86_dvd_x14-55954.iso"
        set "url64=https://example.com/vista_enterprise_sp1_x64.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/WinVistaEnterpriseSP2x86/en_windows_vista_enterprise_sp2_x86_dvd_342329.iso"
        set "url64=https://archive.org/download/WinVistaEnterpriseSP2x64/en_windows_vista_enterprise_sp2_x64_dvd_342332.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
) else if "%edition%"=="Professional" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/en_windows_vista_x64_dvd_x12-40712_20240520/en_windows_vista_x86_dvd_x12-34293.iso"
        set "url64=https://archive.org/download/en_windows_vista_x64_dvd_x12-40712_20240520/en_windows_vista_x64_dvd_x12-40712.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://archive.org/download/en_windows_vista_with_service_pack_1_x86_dvd_x14-29594_202010/en_windows_vista_with_service_pack_1_x86_dvd_x14-29594.iso"
        set "url64=https://archive.org/download/en_windows_vista_with_service_pack_1_x64_dvd_x14-29595_202010/en_windows_vista_with_service_pack_1_x64_dvd_x14-29595.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/en_windows_vista_sp2_x86_dvd_342266/en_windows_vista_sp2_x86_dvd_342266.iso"
        set "url64=https://archive.org/download/en_windows_vista_sp2_x64_dvd_342267_202010/en_windows_vista_sp2_x64_dvd_342267.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
) else if "%edition%"=="HomePremium" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/WinVistaHomePremiumRTMDellOEMx86/Microsoft%20Windows%20Vista%20Home%20Premium%20%28Dell%20Oem%29.iso"
        set "url64=https://archive.org/download/WinVistaRTMAIOENG/Vista_RTM_AIO_DVD-WinBeta.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://archive.org/download/windows-vista-home-premium-sp1-32-bits/FRMCFRE_BR_DVD.iso"
        set "url64=https://archive.org/download/windows-vista-64bit-sp-1/WindowsVista_64bit_SP1.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/WindowsVistaHomeProfessionalSP2/Windows_Vista_Home_Premium_SP2_32_Bit.iso"
        set "url64=https://archive.org/download/windows-vista-sp2-all-in-one-x64-x86/en_windows_vista_sp2_x64_dvd_342267.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
) else if "%edition%"=="HomeBasic" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/en_windows_vista_x64_dvd_x12-40712_20240520/en_windows_vista_x86_dvd_x12-34293.iso"
        set "url64=https://archive.org/download/WinVistaRTMAIOx64/Windows%20Vista%20All%20In%20One%20RTM%20x64%20%28Enu%29.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://example.com/vista_homebasic_sp1_x86.iso"
        set "url64=https://example.com/vista_homebasic_sp1_x64.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/windows-vista-sp2-all-in-one-x64-x86/en_windows_vista_sp2_x86_dvd_342266.iso"
        set "url64=https://archive.org/download/windows-vista-sp2-all-in-one-x64-x86/en_windows_vista_sp2_x64_dvd_342267.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
) else if "%edition%"=="Starter" (
    if "%ver%"=="1" (
        set "url32=https://archive.org/download/windows-vista-starter-rtm/Windows%20Vista%20Starter%20RTM.iso"
    ) else if "%ver%"=="2" (
        set "url32=https://archive.org/download/winvistastarted/winvistastarted.iso"
    ) else if "%ver%"=="3" (
        set "url32=https://archive.org/download/en_windows_vista_sp2_x86_dvd_342266/en_windows_vista_sp2_x86_dvd_342266.iso"
    ) else (
        echo Invalid version selection!
        pause
        goto main
    )
)

set "downloadPath="
set /p downloadPath="Enter the full path to save the ISO (or press Enter to use Downloads folder): "
if "%downloadPath%"=="" set "downloadPath=%downloads%"
if not exist "%downloadPath%" mkdir "%downloadPath%"
set "iso=Vista_%edition%_%ver%_%bitVer%bit.iso"

if "%bitVer%"=="32" (
    set "url=%url32%"
) else (
    set "url=%url64%"
)
set "output=%downloadPath%\%iso%"

goto download

:win7

:win8

:win10
cls
echo.
echo  Windows 10 ISO Download
echo  ========================
echo.

:: Ask for Version First
echo Available Versions:
echo [1] 1507
echo [2] 1511
echo [3] 1607
echo [4] 1703
echo [5] 1709
echo [6] 1803
echo [7] 1809
echo [8] 1903
echo [9] 1909
echo [10] 2004
echo [11] 20H2
echo [12] 21H1
echo [13] 21H2
echo [14] 22H2
echo [15] Enterprise LTSC 2015
echo [16] Enterprise LTSB 2016
echo [17] IoT Enterprise LTSB 2016
echo [18] Enterprise LTSC 2019
echo [19] IoT Enterprise LTSC 2019
echo [20] Enterprise LTSC 2021
echo [21] IoT Enterprise LTSC 2021
echo [22] Cancel and return to Main Menu
echo.
set /p ver="Select a version [1-22]: "

if "%ver%"=="22" goto main

:: Ask Edition (Home/Pro only if applicable)
set "edition="
if %ver% LEQ 14 (
    echo.
    echo Available Editions:
    echo [1] Home
    echo [2] Pro
    set /p ed="Choose Edition [1-2]: "
    if "%ed%"=="1" (
        set "edition=Home"
    ) else if "%ed%"=="2" (
        set "edition=Pro"
    ) else (
        echo Invalid edition!
        pause
        goto win10
    )
)

:: For fixed Enterprise / IoT Enterprise versions
if "%ver%"=="15" set "edition=Enterprise"
if "%ver%"=="16" set "edition=Enterprise"
if "%ver%"=="17" set "edition=IoTEnterprise"
if "%ver%"=="18" set "edition=Enterprise"
if "%ver%"=="19" set "edition=IoTEnterprise"
if "%ver%"=="20" set "edition=Enterprise"
if "%ver%"=="21" set "edition=IoTEnterprise"

:: Ask Architecture
:archLoop
set /p bitVer="Choose architecture [32/64]: "
if /i "%bitVer%"=="32" (
    set "arch=x86"
) else if /i "%bitVer%"=="64" (
    set "arch=x64"
) else (
    echo Invalid input!
    goto archLoop
)

:: Set version name
set "vername="
if "%ver%"=="1" set "vername=1507"
if "%ver%"=="2" set "vername=1511"
if "%ver%"=="3" set "vername=1607"
if "%ver%"=="4" set "vername=1703"
if "%ver%"=="5" set "vername=1709"
if "%ver%"=="6" set "vername=1803"
if "%ver%"=="7" set "vername=1809"
if "%ver%"=="8" set "vername=1903"
if "%ver%"=="9" set "vername=1909"
if "%ver%"=="10" set "vername=2004"
if "%ver%"=="11" set "vername=20H2"
if "%ver%"=="12" set "vername=21H1"
if "%ver%"=="13" set "vername=21H2"
if "%ver%"=="14" set "vername=22H2"
if "%ver%"=="15" set "vername=LTSC_2015"
if "%ver%"=="16" set "vername=LTSB_2016"
if "%ver%"=="17" set "vername=IoT_LTSB_2016"
if "%ver%"=="18" set "vername=LTSC_2019"
if "%ver%"=="19" set "vername=IoT_LTSC_2019"
if "%ver%"=="20" set "vername=LTSC_2021"
if "%ver%"=="21" set "vername=IoT_LTSC_2021"

:: Construct ISO file name
set "iso=Win10_%vername%_%edition%_%arch%.iso"

:: Set download URL placeholder (replace with real links)
set "url=https://example.com/win10_%vername%_%edition%_%arch%.iso"

:: Prompt for path
set "downloadPath="
set /p downloadPath="Enter the full path to save the ISO (or press Enter to use Downloads folder): "
if "%downloadPath%"=="" set "downloadPath=%downloads%"
if not exist "%downloadPath%" mkdir "%downloadPath%"
set "output=%downloadPath%\%iso%"

goto download

:win11
cls
echo.
echo  Windows 11 ISO Download
echo  =======================
echo.
echo Available Windows 11 Versions:
echo [1] 21H2
echo [2] 22H2
echo [3] 23H2
echo [4] 24H2
echo [5] LTSC 2024
echo [6] Cancel and return to main menu
set /p ver="Choose a version [1-6]: "

if "%ver%"=="6" goto main

set "edition="

if "%ver%"=="5" (
    set "edition=LTSC"
) else (
    echo.
    echo Choose edition:
    echo [1] Home
    echo [2] Pro
    set /p ed="Select edition [1-2]: "
    if "%ed%"=="1" (
        set "edition=Home"
    ) else if "%ed%"=="2" (
        set "edition=Pro"
    ) else (
        echo Invalid edition selection!
        pause
        goto win11
    )
)

:: Set ISO filename and download URL
if "%ver%"=="1" (
    if "%edition%"=="Pro" (
        set "url=https://archive.org/download/Win1121H2x64USA/Win11_English_x64v1.iso"
        set "iso=Win11_21H2_Pro_x64.iso"
    ) else if "%edition%"=="Home" (
        set "url=https://archive.org/download/Win1121H2x64USA/Win11_English_x64v1.iso"
        set "iso=Win11_21H2_Home_x64.iso"
    )
) else if "%ver%"=="2" (
    if "%edition%"=="Pro" (
        set "url=https://archive.org/download/win-11-22-h-2-english-x-64v-2_202306/Win11_22H2_English_x64v2.iso"
        set "iso=Win11_22H2_Pro_x64.iso"
    ) else if "%edition%"=="Home" (
        set "url=https://archive.org/download/win-11-22-h-2-english-x-64v-2_202306/Win11_22H2_English_x64v2.iso"
        set "iso=Win11_22H2_Home_x64.iso"
    )
) else if "%ver%"=="3" (
    if "%edition%"=="Pro" (
        set "url=https://archive.org/download/win-11-23-h-2-english-x-64v-2_202410/Win11_23H2_English_x64v2.iso"
        set "iso=Win11_23H2_Pro_x64.iso"
    ) else if "%edition%"=="Home" (
        set "url=https://archive.org/download/win-11-23-h-2-english-x-64v-2_202410/Win11_23H2_English_x64v2.iso"
        set "iso=Win11_23H2_Home_x64.iso"
    )
) else if "%ver%"=="4" (
    if "%edition%"=="Pro" (
        set "url=https://archive.org/download/Win11_24H2_English_x64/Win11_24H2_English_x64.iso"
        set "iso=Win11_24H2_Pro_x64.iso"
    ) else if "%edition%"=="Home" (
        set "url=https://archive.org/download/Win11_24H2_English_x64/Win11_24H2_English_x64.iso"
        set "iso=Win11_24H2_Home_x64.iso"
    )
) else if "%ver%"=="5" (
    set "url=https://example.com/Win11_LTSC_2024.iso"
    set "iso=Win11_LTSC_2024.iso"
) else (
    echo Invalid selection!
    pause
    goto win11
)

set "downloadPath="
set /p downloadPath="Enter the full path to save the ISO (or press Enter to use Downloads folder): "
if "%downloadPath%"=="" set "downloadPath=%downloads%"
if not exist "%downloadPath%" mkdir "%downloadPath%"
set "output=%downloadPath%\%iso%"

goto download

:download
echo  URL: %url%
echo  Saving to: %output%
echo.
echo  Downloading... (Press Ctrl+C to cancel)
echo  Don't close the Window.
echo.
curl -L --progress-bar -o "%output%" "%url%"
if exist "%output%" (
    echo.
    echo ========================================
    echo Download complete! Saved to:
    echo %output%
    echo ========================================
    echo File size: %~zoutput% bytes
) else (
    echo.
    echo Download failed! Possible reasons:
    echo [1] The link doesn't work anymore.
    echo [2] No internet connection.
    echo [3] Not enough disk space.
    echo [4] User canceled the download
)
echo.
pause
goto main
