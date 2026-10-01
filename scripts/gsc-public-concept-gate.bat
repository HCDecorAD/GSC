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
echo [GSC] PUBLIC CONCEPT GATE PASS
exit /b 0
