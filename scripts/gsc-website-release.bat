@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC WEBSITE RELEASE GATE
echo ============================================================

for %%F in (
  gsc-site-pages-gate.bat
  gsc-ai-media-gate.bat
  gsc-public-concept-gate.bat
  qa-flagship.ps1
  qa-responsive.ps1
  qa-gate-wiring.ps1
  qa-ai-media-transaction.ps1
  qa-release-status.ps1
  gsc-public-evidence.bat
) do (
  if not exist "%~dp0%%F" (
    echo [GSC] RELEASE PREFLIGHT FAIL missing %%F
    exit /b 60
  )
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-ai-media-transaction.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-release-status.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-gate-wiring.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp0gsc-site-pages-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp0gsc-public-concept-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-flagship.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-responsive.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp0gsc-public-evidence.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

rem AI media is intentionally the final full-release blocker.
call "%~dp0gsc-ai-media-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ============================================================
echo [GSC] WEBSITE RELEASE PASS
echo ============================================================
exit /b 0
