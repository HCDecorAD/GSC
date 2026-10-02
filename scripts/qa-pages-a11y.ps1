$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$current=([regex]::Matches($t,'aria-current="page"')).Count;$ok=$t.Contains('class="seo-skip"') -and $t.Contains('href="#main-content"') -and $t.Contains('id="main-content"') -and $t.Contains('aria-label="Điều hướng chính"') -and $current -eq 1;"A11Y_PAGE $p current=$current $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
"PAGE_A11Y total=$($pages.Count) failed=$bad";if($bad){exit 54}
