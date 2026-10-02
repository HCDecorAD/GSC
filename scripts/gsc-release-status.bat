@echo off
setlocal EnableDelayedExpansion
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC RELEASE STATUS
echo ============================================================
set "FAIL=0"

call :run "OFFICIAL_PAGES" "%~dp0gsc-site-pages-gate.bat"
call :run "PUBLIC_CONCEPT" "%~dp0gsc-public-concept-gate.bat"
call :runps "FLAGSHIP" "%~dp0qa-flagship.ps1"
call :runps "RESPONSIVE" "%~dp0qa-responsive.ps1"

call "%~dp0gsc-ai-media-gate.bat"
set "MEDIA_RC=!ERRORLEVEL!"
if "!MEDIA_RC!"=="0" (
  echo [PASS] AI_MEDIA
) else (
  echo [PENDING] AI_MEDIA rc=!MEDIA_RC! - concept assets are not release-ready
)

echo ------------------------------------------------------------
if "!FAIL!"=="0" (
  echo [GSC] WEBSITE CODE/CONTENT QA PASS
) else (
  echo [GSC] WEBSITE CODE/CONTENT QA FAIL
)
if "!MEDIA_RC!"=="0" (
  echo [GSC] AI MEDIA PASS
) else (
  echo [GSC] AI MEDIA PENDING
)
echo ============================================================
if not "!FAIL!"=="0" exit /b 61
if not "!MEDIA_RC!"=="0" exit /b !MEDIA_RC!
exit /b 0

:run
call %~2
set "RC=!ERRORLEVEL!"
if "!RC!"=="0" (echo [PASS] %~1) else (echo [FAIL] %~1 rc=!RC!&set "FAIL=1")
exit /b 0

:runps
powershell -NoProfile -ExecutionPolicy Bypass -File %~2
set "RC=!ERRORLEVEL!"
if "!RC!"=="0" (echo [PASS] %~1) else (echo [FAIL] %~1 rc=!RC!&set "FAIL=1")
exit /b 0
