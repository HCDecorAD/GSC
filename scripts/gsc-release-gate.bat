@echo off
setlocal EnableExtensions
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo [GSC] Release gate
call scripts\gsc-parallel-qa.bat
if errorlevel 1 (
  echo [GSC] FAIL: regression QA
  exit /b 20
)
git diff --quiet
if errorlevel 1 (
  echo [GSC] FAIL: tracked working tree changes
  exit /b 21
)
git diff --cached --quiet
if errorlevel 1 (
  echo [GSC] FAIL: staged working tree changes
  exit /b 22
)
echo [GSC] RELEASE GATE PASS
exit /b 0
