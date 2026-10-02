@echo off
setlocal EnableDelayedExpansion
set "ROOT=%~dp0.."
set "CFG=%ROOT%\config\gsc-intro-assets.json"
set "BAK=%TEMP%\gsc-intro-assets-transaction-%RANDOM%-%RANDOM%.json"
cd /d "%ROOT%"
echo ============================================================
echo GSC AI MEDIA TRANSACTIONAL IMPORT
echo ============================================================
copy /y "%CFG%" "%BAK%" >nul
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0map-ai-media.ps1"
if errorlevel 1 (
  copy /y "%BAK%" "%CFG%" >nul
  del /q "%BAK%" >nul 2>&1
  echo [GSC] AI MEDIA MAP BLOCKED - CONFIG ROLLED BACK
  exit /b !ERRORLEVEL!
)
call "%~dp0gsc-ai-media-gate.bat"
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" (
  copy /y "%BAK%" "%CFG%" >nul
  del /q "%BAK%" >nul 2>&1
  echo [GSC] AI MEDIA GATE FAILED - CONFIG ROLLED BACK rc=!RC!
  exit /b !RC!
)
del /q "%BAK%" >nul 2>&1
echo [GSC] AI MEDIA IMPORT COMMITTED
exit /b 0
