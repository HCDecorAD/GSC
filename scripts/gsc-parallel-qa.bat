@echo off
setlocal EnableExtensions
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"
echo [GSC] QA started %date% %time%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-html.ps1" > "%QA%\html.log" 2>&1
set "E1=%ERRORLEVEL%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-assets.ps1" > "%QA%\assets.log" 2>&1
set "E2=%ERRORLEVEL%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-contact.ps1" > "%QA%\contact.log" 2>&1
set "E3=%ERRORLEVEL%"
git status --short > "%QA%\git.log" 2>&1

type "%QA%\html.log"
type "%QA%\assets.log"
type "%QA%\contact.log"
type "%QA%\git.log"

if not "%E1%"=="0" exit /b 12
if not "%E2%"=="0" exit /b 15
if not "%E3%"=="0" exit /b 16
echo [GSC] PASS
exit /b 0
