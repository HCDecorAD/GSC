$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html')
$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$ok=$t.Contains('class="seo-menu"') -and $t.Contains('aria-controls="seo-page-nav"') -and $t.Contains('js/gsc-pages.js') -and $t.Contains("url('/assets/");"PAGE_UX $p $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
$j=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-pages.js'));if(!$j.Contains("Escape")){$bad++;"PAGE_UX shared-js FAIL"}
"PAGE_UX total=$($pages.Count) failed=$bad";if($bad){exit 51}

$css=[IO.File]::ReadAllText((Join-Path $root 'css/gsc-pages.css'))
$reducedMotion=($css -match '@media\s*\(prefers-reduced-motion:\s*reduce\)' -and $css -match 'scroll-behavior\s*:\s*auto')
Write-Host "SITE_UX reduced-motion $(if($reducedMotion){'PASS'}else{'FAIL'})"
if(!$reducedMotion){exit 51}

$js=[IO.File]::ReadAllText((Join-Path $root 'js/gsc-pages.js'))
$focusReturn=($js -match "if\(e\.key==='Escape'\)close\(true\)" -and $js -match 'menu\.focus\(\)')
Write-Host "SITE_UX escape-focus-return $(if($focusReturn){'PASS'}else{'FAIL'})"
if(!$focusReturn){exit 51}
