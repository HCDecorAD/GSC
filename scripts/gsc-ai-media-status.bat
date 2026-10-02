@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0.."
echo [GSC] AI MEDIA STATUS
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-Content 'config\gsc-intro-assets.json' -Raw|ConvertFrom-Json; $m=Get-Content 'config\gsc-ai-media-manifest.json' -Raw|ConvertFrom-Json; $slots=@('seniorliving','healthcare','active','community','daily','location'); $approved=0; $mapped=0; foreach($s in $slots){$meta=$m.slots.$s; $canonical=[string]$meta.path; $current=[string]$c.assets.$s; $a=($meta.approved -eq $true -and $meta.scene_only -eq $true -and $meta.no_text_ui -eq $true); $map=(!$([string]::IsNullOrWhiteSpace($current)) -and $current -ceq $canonical); if($a){$approved++}; if($map){$mapped++}; Write-Host ('[{0}] {1} approved={2} mapped={3} current={4} canonical={5}' -f $(if($a){'x'}else{' '}),$s,$a,$map,$(if([string]::IsNullOrWhiteSpace($current)){'EMPTY'}else{$current}),$canonical)}; Write-Host ('AI_MEDIA_STATUS approved={0}/6 mapped={1}/6 complete={2}' -f $approved,$mapped,$($approved -eq 6 -and $mapped -eq 6))"
set "STATUS_RC=!ERRORLEVEL!"
if not "!STATUS_RC!"=="0" exit /b !STATUS_RC!
echo.
echo Run full validation:
call "%~dp0gsc-ai-media-gate.bat"
set "GATE_RC=!ERRORLEVEL!"
exit /b !GATE_RC!
