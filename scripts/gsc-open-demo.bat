@echo off
setlocal
set "BASE=https://gscsenior.hcdecorhub.com"
where msedge >nul 2>&1
if %ERRORLEVEL%==0 (
  start "" msedge --new-window "%BASE%/gsc-introduction.html"
  start "" msedge --new-window "%BASE%/"
  exit /b 0
)
where chrome >nul 2>&1
if %ERRORLEVEL%==0 (
  start "" chrome --new-window "%BASE%/gsc-introduction.html"
  start "" chrome --new-window "%BASE%/"
  exit /b 0
)
start "" "%BASE%/gsc-introduction.html"
start "" "%BASE%/"
exit /b 0
