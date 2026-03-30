@echo off
title LX TOOLS - PC Optimizer 2026
color 0B
setlocal enabledelayedexpansion

:: Check for Administrative Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERROR: Please right-click LX_Tools.bat and 'Run as Administrator'.
    pause
    exit /b
)

:MENU
cls
echo ======================================================
echo           LX TOOLS ^| PC OPTIMIZATION SUITE
echo ======================================================
echo  [1] Quick Clean (Temp Files, DNS, Recycle Bin)
echo  [2] High Performance (Power Plan)
echo  [3] Disable Transparency (Boost GPU)
echo  [4] Mouse Tweak (Disable Acceleration/1:1 Input)
echo  [5] FULL OPTIMIZE (Run All)
echo  [6] Exit
echo ======================================================
set /p choice="Select an option (1-6): "

if "%choice%"=="1" goto CLEAN
if "%choice%"=="2" goto PERFORMANCE
if "%choice%"=="3" goto TRANSPARENCY
if "%choice%"=="4" goto MOUSE
if "%choice%"=="5" goto FULL
if "%choice%"=="6" exit

:CLEAN
echo.
echo [+] Purging Junk Files...
del /s /f /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
mkdir %temp%
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
echo [+] Flushing DNS...
ipconfig /flushdns >nul
echo [+] Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1
echo [OK] Cleanup Complete.
pause
goto MENU

:PERFORMANCE
echo.
echo [+] Setting High Performance Power Plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo [+] Optimizing NTFS Memory Usage...
fsutil behavior set memoryusage 2 >nul
echo [OK] Performance settings applied.
pause
goto MENU

:TRANSPARENCY
echo.
echo [+] Disabling Windows Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul
echo [OK] Transparency disabled (saves GPU resources).
pause
goto MENU

:MOUSE
echo.
echo [+] Disabling Mouse Acceleration (Enhance Pointer Precision)...
:: Sets MouseSpeed to 0, and Thresholds to 0 for raw-feeling input
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
echo [OK] Mouse Tweak applied. (May require logout/restart to feel effect).
pause
goto MENU

:FULL
echo.
echo Running Full LX Optimization...
call :CLEAN
call :PERFORMANCE
call :TRANSPARENCY
call :MOUSE
echo.
echo ======================================================
echo           LX TOOLS: FULL OPTIMIZATION FINISHED
echo ======================================================
pause
goto MENU