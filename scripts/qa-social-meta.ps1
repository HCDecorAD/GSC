$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html');$bad=0
foreach($p in $pages){$t=[IO.File]::ReadAllText((Join-Path $root $p));$checks=@($t.Contains('<meta property="og:title"'),$t.Contains('<meta property="og:description"'),$t.Contains('<meta property="og:url"'),$t.Contains('<meta property="og:image"'),$t.Contains('<meta property="og:image:alt"'),$t.Contains('name="twitter:card" content="summary_large_image"'),$t.Contains('name="theme-color"'),$t.Contains('name="robots"'));$ok=($checks -notcontains $false);"SOCIAL_META $p $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}}
"SEO_SOCIAL total=$($pages.Count) failed=$bad";if($bad){exit 53}
