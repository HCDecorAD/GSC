@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$sm=[IO.File]::ReadAllText('sitemap.xml');$bad=0;foreach($p in $pages){$t=[IO.File]::ReadAllText($p);$canon='https://gscsenior.hcdecorhub.com/'+$p;$checks=@($t -match [regex]::Escape('rel="canonical" href="'+$canon+'"'),$t -match 'BreadcrumbList',$t -match 'gsc-introduction.html',$t -match 'contact.html',$sm -match [regex]::Escape($canon));$ok=($checks -notcontains $false);Write-Host ('SITE_ARCH '+$p+' '+$(if($ok){'PASS'}else{'FAIL'}));if(!$ok){$bad++}};if($bad){exit 46}"
if errorlevel 1 exit /b %ERRORLEVEL%
echo [GSC] SITE ARCHITECTURE PASS
exit /b 0
