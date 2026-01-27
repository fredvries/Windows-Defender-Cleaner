@echo off
setlocal enabledelayedexpansion

:: --------------------------------------------
:: Windows Defender Cleaner 1.4
:: --------------------------------------------

:: Channel names
set "CH_DEFENDER=Microsoft-Windows-Windows Defender/Operational"
set "CH_WHC=Microsoft-Windows-Windows Defender/WHC"

:: [1] Clear Windows Defender Security (Operational) log
wevtutil cl "%CH_DEFENDER%" >nul 2>nul

:: [2] Clear Windows Health Center (WHC) log
wevtutil cl "%CH_WHC%" >nul 2>nul

:: [3] Clear Protection History database
set "PH_PATH=C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"

net stop WinDefend /y >nul 2>nul
net stop SecurityHealthService >nul 2>nul

del /f /q "%PH_PATH%\*" >nul 2>nul

net start WinDefend >nul 2>nul
net start SecurityHealthService >nul 2>nul

echo.
echo [1] Windows Defender Security Log successfully cleaned
echo [2] Windows Health Center or WHC log successfully cleaned
echo [3] Protection History successfully cleaned
echo.

timeout /t 7 >nul

endlocal
exit /b
