@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$bad=0;foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $PWD $p));$ok=$t -match '<title>.+</title>' -and $t -match 'meta name="description"' -and $t -match 'rel="canonical"' -and $t -match '<h1>';Write-Host ('SEO_PAGE '+$p+' '+$(if($ok){'PASS'}else{'FAIL'}));if(!$ok){$bad++}};if($bad){exit 44}"
if errorlevel 1 exit /b %ERRORLEVEL%
echo [GSC] OFFICIAL SEO PAGES PASS
exit /b 0
