$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path;$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$ok=$t.Contains('rel="preload" as="image"') -and $t.Contains('fetchpriority="high"') -and $t.Contains('rel="preload" href="assets/fonts/UTMAvo-Bold.ttf"') -and $t.Contains('rel="icon" href="assets/gsc-web/gsc-icon.jpg"') -and $t.Contains('src="js/gsc-pages.js" defer');"PERF_HINT $p $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
$r=[IO.File]::ReadAllText((Join-Path $root 'robots.txt'));$sm=[IO.File]::ReadAllText((Join-Path $root 'sitemap.xml'));if(!$r.Contains('Sitemap: https://gscsenior.hcdecorhub.com/sitemap.xml')){$bad++};foreach($p in $pages){if(!$sm.Contains("https://gscsenior.hcdecorhub.com/$p")){$bad++}}
"PERF_CRAWL failed=$bad";if($bad){exit 55}
