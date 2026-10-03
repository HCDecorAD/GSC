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

$desktopReset=($js -match "matchMedia\('\(max-width: 900px\)'\)" -and $js -match "addEventListener\?\.\('change'" -and $js -match 'if\(!e\.matches\)close\(\)')
Write-Host "SITE_UX desktop-menu-reset $(if($desktopReset){'PASS'}else{'FAIL'})"
if(!$desktopReset){exit 51}

$themeNormalized=($js -match "t!==\'light\'&&t!==\'dark\'" -and $js -match "prefers-color-scheme: light" -and $js -match "writeTheme\(v\)")
$storageResilient=($js -match 'readTheme=.*try' -and $js -match 'writeTheme=.*try' -and $js -match 'localStorage\.setItem\(k,v\)')
Write-Host "SITE_UX theme-state-normalized $(if($themeNormalized){'PASS'}else{'FAIL'})"
if(!$themeNormalized){exit 51}
Write-Host "SITE_UX storage-resilient $(if($storageResilient){'PASS'}else{'FAIL'})"
if(!$storageResilient){exit 51}
