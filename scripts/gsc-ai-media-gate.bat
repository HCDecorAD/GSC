@echo off
setlocal EnableDelayedExpansion
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-ai-media-intake.ps1"
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" exit /b !RC!

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-ai-concept.ps1" > "%QA%\ai-media.log" 2>&1
set "RC=!ERRORLEVEL!"
type "%QA%\ai-media.log"
if not "!RC!"=="0" (
 echo [GSC] AI MEDIA NOT COMPLETE rc=!RC!
 exit /b !RC!
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-ai-media-policy.ps1"
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" exit /b !RC!

echo [GSC] AI MEDIA 6/6 PASS
exit /b 0
