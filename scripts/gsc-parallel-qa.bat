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
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-accessibility.ps1" > "%QA%\accessibility.log" 2>&1
set "E4=%ERRORLEVEL%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-seo.ps1" > "%QA%\seo.log" 2>&1
set "E5=%ERRORLEVEL%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-runtime.ps1" > "%QA%\runtime.log" 2>&1
set "E6=%ERRORLEVEL%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-responsive.ps1" > "%QA%\responsive.log" 2>&1
set "E7=%ERRORLEVEL%"
git status --short > "%QA%\git.log" 2>&1

type "%QA%\html.log"
type "%QA%\assets.log"
type "%QA%\contact.log"
type "%QA%\accessibility.log"
type "%QA%\seo.log"
type "%QA%\runtime.log"
type "%QA%\responsive.log"
type "%QA%\git.log"

if not "%E1%"=="0" exit /b 12
if not "%E2%"=="0" exit /b 15
if not "%E3%"=="0" exit /b 16
if not "%E4%"=="0" exit /b 17
if not "%E5%"=="0" exit /b 18
if not "%E6%"=="0" exit /b 19
if not "%E7%"=="0" exit /b 20
echo [GSC] PASS
exit /b 0
