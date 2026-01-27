@echo off
setlocal enabledelayedexpansion

:: ----------------------------------------------------
:: Windows Defender Cleaner (with logging + boot cleanup)
:: ----------------------------------------------------

:: Base folder = folder of this script
set "BASE=%~dp0"

:: Create timestamp for log file
set "TS=%date%_%time%"
set "TS=%TS::=-%"
set "TS=%TS:/=-%"
set "TS=%TS: =_%"
set "TS=%TS:,=-%"
set "TS=%TS:.=-%"

set "LOGFILE=%BASE%Defender_Clean_Log_%TS%.txt"

echo Windows Defender Cleaner > "%LOGFILE%"
echo ---------------------------------------------- >> "%LOGFILE%"
echo Started: %date% %time% >> "%LOGFILE%"
echo. >> "%LOGFILE%"

:: Channel names
set "CH_DEFENDER=Microsoft-Windows-Windows Defender/Operational"
set "CH_WHC=Microsoft-Windows-Windows Defender/WHC"

:: [1] Clear Windows Defender Security (Operational) log
echo Cleaning Defender Operational log... >> "%LOGFILE%"
wevtutil cl "%CH_DEFENDER%" >> "%LOGFILE%" 2>&1

:: [2] Clear Windows Health Center (WHC) log
echo Cleaning WHC log... >> "%LOGFILE%"
wevtutil cl "%CH_WHC%" >> "%LOGFILE%" 2>&1

:: [3] Protection History cleanup (boot‑time method)
echo Scheduling Protection History cleanup at next reboot... >> "%LOGFILE%"

set "PH_PATH=C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"
set "CLEANER=%temp%\ph_clean.bat"

:: Create the boot‑time cleaner script
echo @echo off > "%CLEANER%"
echo del /f /q "%PH_PATH%\*" ^>nul 2^>nul >> "%CLEANER%"
echo exit >> "%CLEANER%"

:: Register it to run once at next boot
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce /v PHClean /t REG_SZ /d "\"%CLEANER%\"" /f >> "%LOGFILE%" 2>&1

echo Boot‑time cleanup registered. >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo Completed: %date% %time% >> "%LOGFILE%"
echo ---------------------------------------------- >> "%LOGFILE%"

:: Final on‑screen messages
echo.
echo [1] Windows Defender Security Log successfully cleaned
echo [2] Windows Health Center or WHC log successfully cleaned
echo [3] Protection History will be cleaned at next reboot
echo.
echo Log saved as:
echo %LOGFILE%
echo.

:: Keep window open long enough for users to read
timeout /t 7 >nul

endlocal
exit /b

