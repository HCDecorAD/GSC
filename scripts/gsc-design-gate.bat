@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo [GSC DESIGN] START
call "%~dp0gsc-ai-media-gate.bat"
if errorlevel 1 echo [GSC DESIGN] MEDIA PENDING
call "%~dp0gsc-public-concept-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
echo [GSC DESIGN] FULL DESIGN + PRODUCTION PASS
exit /b 0
