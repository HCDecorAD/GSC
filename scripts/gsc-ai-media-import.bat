@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC AI MEDIA IMPORT + MAP
echo ============================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0map-ai-media.ps1"
if errorlevel 1 (
  echo [GSC] AI MEDIA MAP BLOCKED
  exit /b %ERRORLEVEL%
)
call "%~dp0gsc-ai-media-gate.bat"
if errorlevel 1 (
  echo [GSC] AI MEDIA MAPPED BUT GATE FAILED
  exit /b %ERRORLEVEL%
)
echo [GSC] AI MEDIA IMPORT + MAP PASS
exit /b 0
