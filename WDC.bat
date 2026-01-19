@echo off
setlocal enabledelayedexpansion

echo Windows Defender Cleaner 1.2
echo ----------------------------------

:: Define log file paths
set "LOG_OP=C:\Windows\System32\winevt\Logs\Microsoft-Windows-Windows Defender%4Operational.evtx"
set "LOG_WHC=C:\Windows\System32\winevt\Logs\Microsoft-Windows-Windows Defender%4WHC.evtx"

:: Clean both logs
call :CleanLog "Operational" "%LOG_OP%" "Microsoft-Windows-Windows Defender/Operational"
call :CleanLog "WHC" "%LOG_WHC%" "Microsoft-Windows-Windows Defender/WHC"

@echo off
setlocal enabledelayedexpansion

echo Windows Defender Cleaner 1.2
echo ----------------------------------------------------

:: Paths for Defender logs
set "LOG_WHC=C:\Windows\System32\winevt\Logs\Microsoft-Windows-Windows Defender%4WHC.evtx"

:: Clean WHC log
call :CleanLog "WHC" "%LOG_WHC%" "Microsoft-Windows-Windows Defender/WHC"

:: Clean Security log
call :CleanSecurity

echo ----------------------------------------------------
echo Cleaning complete.
pause
exit /b

:CleanLog
echo.
echo Cleaning %~1 log...
echo ------------------------------

:: Count entries before
for /f %%A in ('wevtutil qe "%~3" /f:text ^| find /c ":"') do set COUNT_BEFORE=%%A
echo Entries before: %COUNT_BEFORE%

:: Clear the log
wevtutil cl "%~3"
if errorlevel 1 (
echo Failed to clear %~1 log.
goto :EOF
)

:: Count entries after
for /f %%A in ('wevtutil qe "%~3" /f:text ^| find /c ":"') do set COUNT_AFTER=%%A
echo Entries after: %COUNT_AFTER%

:: Calculate removed entries
set /a REMOVED=%COUNT_BEFORE% - %COUNT_AFTER%
echo Removed: %REMOVED% entries

goto :EOF

:CleanSecurity
echo.
echo Cleaning Security log...
echo ------------------------------

:: Count entries before
for /f %%A in ('wevtutil qe Security /f:text ^| find /c ":"') do set SEC_BEFORE=%%A
echo Entries before: %SEC_BEFORE%

:: Clear the Security log
wevtutil cl Security
if errorlevel 1 (
echo Failed to clear Security log.
echo (You may need the "Manage auditing and security log" privilege.)
goto :EOF
)

:: Count entries after
for /f %%A in ('wevtutil qe Security /f:text ^| find /c ":"') do set SEC_AFTER=%%A
echo Entries after: %SEC_AFTER%

:: Calculate removed entries
set /a SEC_REMOVED=%SEC_BEFORE% - %SEC_AFTER%
echo Removed: %SEC_REMOVED% entries

goto :EOF