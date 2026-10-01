@echo off
setlocal EnableExtensions
set "ROOT=%~dp0.."
set "QA=%ROOT%\.qa"
cd /d "%ROOT%"
if not exist "%QA%" mkdir "%QA%"
call scripts\gsc-release-gate.bat
set "RC=%ERRORLEVEL%"
for /f %%i in ('git rev-parse HEAD') do set "COMMIT=%%i"
> "%QA%\checkpoint.txt" echo GSC CHECKPOINT
>> "%QA%\checkpoint.txt" echo commit=%COMMIT%
>> "%QA%\checkpoint.txt" echo date=%date% %time%
>> "%QA%\checkpoint.txt" echo release_gate_exit=%RC%
if "%RC%"=="0" (
  >> "%QA%\checkpoint.txt" echo status=PASS
) else (
  >> "%QA%\checkpoint.txt" echo status=FAIL
)
type "%QA%\checkpoint.txt"
exit /b %RC%
