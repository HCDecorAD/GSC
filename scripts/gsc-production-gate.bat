@echo off
setlocal
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"
call scripts\gsc-final-audit.bat
if errorlevel 1 exit /b %ERRORLEVEL%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-production.ps1" > "%QA%\production.log" 2>&1
set "RC=%ERRORLEVEL%"
type "%QA%\production.log"
if not "%RC%"=="0" exit /b %RC%
echo [GSC] SOURCE + PRODUCTION SMOKE PASS
exit /b 0
