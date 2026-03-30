@echo off
title lx tweak
color 0c

:menu
cls
echo ===============================
echo        RISXN TWEAKS GUI
echo ===============================
echo.
echo [1] Optimize FPS
echo [2] Reduce Input Delay
echo [3] Network Boost
echo [4] Clean System
echo [5] Full Boost (All)
echo [6] Exit
echo.
set /p choice=Select an option:

if %choice%==1 goto fps
if %choice%==2 goto input
if %choice%==3 goto network
if %choice%==4 goto clean
if %choice%==5 goto full
if %choice%==6 exit

goto menu

:fps
cls
echo Applying FPS tweaks...

powercfg -setactive SCHEME_MIN
sc stop "SysMain" >nul 2>&1
wmic process where name="FortniteClient-Win64-Shipping.exe" CALL setpriority 256 >nul 2>&1

echo Done!
pause
goto menu

:input
cls
echo Reducing input delay...

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f

echo Done!
pause
goto menu

:network
cls
echo Optimizing network...

ipconfig /flushdns
netsh int tcp set global autotuninglevel=disabled >nul
netsh winsock reset >nul

echo Done! (Restart recommended)
pause
goto menu

:clean
cls
echo Cleaning system...

del /s /f /q %temp%\* >nul 2>&1
del /s /f /q C:\Windows\Temp\* >nul 2>&1

echo Done!
pause
goto menu

:full
cls
echo Applying FULL BOOST...

:: Combine everything
powercfg -setactive SCHEME_MIN
sc stop "SysMain" >nul 2>&1

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f

ipconfig /flushdns
netsh winsock reset >nul

del /s /f /q %temp%\* >nul 2>&1

wmic process where name="FortniteClient-Win64-Shipping.exe" CALL setpriority 256 >nul 2>&1

echo FULL BOOST APPLIED!
pause
goto menu