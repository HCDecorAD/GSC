@echo off
setlocal
cd /d "%~dp0.."
echo [GSC] AI MEDIA STATUS
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-Content 'config\gsc-intro-assets.json' -Raw|ConvertFrom-Json; @('seniorliving','healthcare','active','community','daily','location')|%%{$v=$c.assets.$_; if([string]::IsNullOrWhiteSpace($v)){Write-Host ('[ ] '+$_+' = EMPTY')}else{Write-Host ('[x] '+$_+' = '+$v)}}"
echo.
echo Run full validation:
call "%~dp0gsc-ai-media-gate.bat"
exit /b %ERRORLEVEL%
