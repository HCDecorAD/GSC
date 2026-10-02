@echo off
setlocal EnableDelayedExpansion
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC RELEASE STATUS
echo ============================================================
set "SOURCE_FAIL=0"

call :sourcebat "OFFICIAL_PAGES" "%~dp0gsc-site-pages-gate.bat"
call :sourcebat "PUBLIC_CONCEPT" "%~dp0gsc-public-concept-gate.bat"
call :sourceps "FLAGSHIP" "%~dp0qa-flagship.ps1"
call :sourceps "RESPONSIVE" "%~dp0qa-responsive.ps1"

call "%~dp0gsc-public-evidence.bat"
set "PUBLIC_RC=!ERRORLEVEL!"
if "!PUBLIC_RC!"=="0" (echo [PASS] PUBLIC_DEPLOYMENT) else (echo [NOT_CONFIRMED] PUBLIC_DEPLOYMENT rc=!PUBLIC_RC!)

call "%~dp0gsc-ai-media-gate.bat"
set "MEDIA_RC=!ERRORLEVEL!"
if "!MEDIA_RC!"=="0" (echo [PASS] AI_MEDIA) else (echo [PENDING] AI_MEDIA rc=!MEDIA_RC!)

echo ------------------------------------------------------------
if "!SOURCE_FAIL!"=="0" (echo [GSC] SOURCE QA PASS) else (echo [GSC] SOURCE QA FAIL)
if "!PUBLIC_RC!"=="0" (echo [GSC] PUBLIC DEPLOYMENT PASS) else (echo [GSC] PUBLIC DEPLOYMENT NOT CONFIRMED)
if "!MEDIA_RC!"=="0" (echo [GSC] AI MEDIA PASS) else (echo [GSC] AI MEDIA PENDING)
echo ============================================================
if not "!SOURCE_FAIL!"=="0" exit /b 61
if not "!PUBLIC_RC!"=="0" exit /b !PUBLIC_RC!
if not "!MEDIA_RC!"=="0" exit /b !MEDIA_RC!
exit /b 0

:sourcebat
call %~2
set "RC=!ERRORLEVEL!"
if "!RC!"=="0" (echo [PASS] %~1) else (echo [FAIL] %~1 rc=!RC!&set "SOURCE_FAIL=1")
exit /b 0

:sourceps
powershell -NoProfile -ExecutionPolicy Bypass -File %~2
set "RC=!ERRORLEVEL!"
if "!RC!"=="0" (echo [PASS] %~1) else (echo [FAIL] %~1 rc=!RC!&set "SOURCE_FAIL=1")
exit /b 0
