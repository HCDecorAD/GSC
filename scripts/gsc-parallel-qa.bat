@echo off
setlocal EnableExtensions
cd /d "%~dp0"
if not exist ".qa" mkdir ".qa"
echo [GSC] Parallel QA started %date% %time%

start "GSC-QA-HTML" /b cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File scripts\qa-html.ps1 > .qa\html.log 2>&1"
start "GSC-QA-ASSETS" /b cmd /c "powershell -NoProfile -ExecutionPolicy Bypass -File scripts\qa-assets.ps1 > .qa\assets.log 2>&1"
start "GSC-QA-GIT" /b cmd /c "git status --short > .qa\git.log 2>&1"

:wait
timeout /t 1 /nobreak >nul
tasklist /fi "WINDOWTITLE eq GSC-QA-HTML" 2>nul | find /i "cmd.exe" >nul && goto wait
tasklist /fi "WINDOWTITLE eq GSC-QA-ASSETS" 2>nul | find /i "cmd.exe" >nul && goto wait

echo [GSC] QA complete. Reports: .qa\
type .qa\html.log
type .qa\assets.log
type .qa\git.log
endlocal
