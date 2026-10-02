$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html')
$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$ok=$t.Contains('class="seo-menu"') -and $t.Contains('aria-controls="seo-page-nav"') -and $t.Contains('js/gsc-pages.js') -and $t.Contains("url('/assets/");"PAGE_UX $p $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
$j=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-pages.js'));if(!$j.Contains("Escape")){$bad++;"PAGE_UX shared-js FAIL"}
"PAGE_UX total=$($pages.Count) failed=$bad";if($bad){exit 51}
