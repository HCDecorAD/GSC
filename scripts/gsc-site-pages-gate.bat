@echo off
setlocal
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"

call "%~dp0gsc-seo-pages-gate.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp0gsc-site-architecture-gate.bat"
if errorlevel 1 exit /b !ERRORLEVEL!
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-sitemap.ps1"
if errorlevel 1 exit /b %ERRORLEVEL%

for %%Q in (
  qa-content-pages.ps1
  qa-site-ux.ps1
  qa-page-integrity.ps1
  qa-social-meta.ps1
  qa-pages-a11y.ps1
  qa-performance-crawl.ps1
  qa-schema-pages.ps1
  qa-internal-links.ps1
  qa-faq-pages.ps1
) do (
  echo [GSC] Running %%Q
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0%%Q"
  if errorlevel 1 exit /b %ERRORLEVEL%
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0qa-site-pages.ps1" > "%QA%\site-pages.log" 2>&1
set "RC=%ERRORLEVEL%"
type "%QA%\site-pages.log"
if not "%RC%"=="0" exit /b %RC%

echo [GSC] OFFICIAL SITE PAGES + PRODUCTION PASS
exit /b 0
