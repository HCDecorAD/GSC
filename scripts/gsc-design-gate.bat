@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo [GSC DESIGN] START
call "%~dp0gsc-ai-media-gate.bat"
set "MEDIA_RC=%ERRORLEVEL%"
if not "%MEDIA_RC%"=="0" echo [GSC DESIGN] MEDIA PENDING rc=%MEDIA_RC%
call "%~dp0gsc-public-concept-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
if not "%MEDIA_RC%"=="0" exit /b %MEDIA_RC%
echo [GSC DESIGN] FULL DESIGN + PRODUCTION PASS
exit /b 0
