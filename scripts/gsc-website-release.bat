@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo ============================================================
echo GSC WEBSITE RELEASE GATE
echo ============================================================
call "%~dp0gsc-site-pages-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
call "%~dp0gsc-ai-media-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
call "%~dp0gsc-public-concept-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
echo ============================================================
echo [GSC] WEBSITE RELEASE PASS
echo ============================================================
exit /b 0
