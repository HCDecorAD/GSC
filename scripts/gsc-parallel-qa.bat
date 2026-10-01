@echo off
setlocal EnableExtensions
set "ROOT=%~dp0.."
set "SCRIPTS=%~dp0"
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"
echo [GSC] Parallel QA started %date% %time%

start "" /b cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File ""%SCRIPTS%qa-html.ps1"" > ""%QA%\html.log"" 2>&1"
start "" /b cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File ""%SCRIPTS%qa-assets.ps1"" > ""%QA%\assets.log"" 2>&1"
git status --short > "%QA%\git.log" 2>&1

timeout /t 5 /nobreak >nul
echo [GSC] QA reports
if exist "%QA%\html.log" type "%QA%\html.log"
if exist "%QA%\assets.log" type "%QA%\assets.log"
if exist "%QA%\git.log" type "%QA%\git.log"

findstr /b /c:"HTML_QA" "%QA%\html.log" >nul || exit /b 10
findstr /b /c:"ASSET_QA" "%QA%\assets.log" >nul || exit /b 11
findstr /c:"duplicateIds=0" "%QA%\html.log" >nul || exit /b 12
findstr /c:"brokenAnchors=0" "%QA%\html.log" >nul || exit /b 13
findstr /c:"legacyFonts=0" "%QA%\html.log" >nul || exit /b 14
findstr /c:"missing=0" "%QA%\assets.log" >nul || exit /b 15
echo [GSC] PASS
exit /b 0
