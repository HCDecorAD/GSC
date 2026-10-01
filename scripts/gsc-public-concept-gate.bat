@echo off
setlocal
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
call scripts\gsc-production-gate.bat
if errorlevel 1 exit /b %ERRORLEVEL%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-ai-concept.ps1" > "%QA%\ai-concept.log" 2>&1
set "RC=%ERRORLEVEL%"
type "%QA%\ai-concept.log"
if not "%RC%"=="0" exit /b %RC%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-architecture.ps1" > "%QA%\architecture.log" 2>&1
set "AR=%ERRORLEVEL%"
type "%QA%\architecture.log"
if not "%AR%"=="0" exit /b %AR%
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-theme.ps1" > "%QA%\theme.log" 2>&1
set "TR=%ERRORLEVEL%"
type "%QA%\theme.log"
if not "%TR%"=="0" exit /b %TR%
echo [GSC] PUBLIC CONCEPT + THEME + GITHUB PAGES ARCHITECTURE PASS
exit /b 0
