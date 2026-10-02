@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC PUBLIC DEPLOYMENT EVIDENCE
echo ============================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-public-evidence.ps1"
set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" (
  echo [GSC] PUBLIC EVIDENCE NOT CONFIRMED rc=%RC%
  exit /b %RC%
)
echo [GSC] PUBLIC EVIDENCE PASS
exit /b 0
