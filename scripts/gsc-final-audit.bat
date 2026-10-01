@echo off
setlocal EnableExtensions
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"
call scripts\gsc-checkpoint.bat
set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" exit /b %RC%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-integrity.ps1" > "%QA%\integrity.log" 2>&1
set "IR=%ERRORLEVEL%"
type "%QA%\integrity.log"
if not "%IR%"=="0" exit /b 30
for /f %%i in ('git rev-parse HEAD') do set "COMMIT=%%i"
echo FINAL_AUDIT commit=%COMMIT% status=PASS
exit /b 0
