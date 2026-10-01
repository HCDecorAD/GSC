$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html')
$bad=0
foreach($p in $pages){
 $t=[IO.File]::ReadAllText((Join-Path $root $p))
 $plain=[regex]::Replace($t,'<[^>]+>',' ')
 $words=($plain -split '\s+'|Where-Object{$_.Length -gt 1}).Count
 $h1=([regex]::Matches($t,'<h1[ >]')).Count
 $desc=($t -match '<meta name="description" content="[^"]{40,}"')
 $canon=($t -match '<link rel="canonical" href="https://gscsenior\.hcdecorhub\.com/[^"]+"')
 $schema=($t -match 'BreadcrumbList')
 $nav=($t -match 'project\.html' -and $t -match 'wellness\.html' -and $t -match 'location\.html' -and $t -match 'contact\.html')
 $ok=($words -ge 120 -and $h1 -eq 1 -and $desc -and $canon -and $schema -and $nav)
 "CONTENT_QA $p words=$words h1=$h1 desc=$desc canonical=$canon schema=$schema nav=$nav status=$(if($ok){'PASS'}else{'FAIL'})"
 if(!$ok){$bad++}
}
"CONTENT_QA total=$($pages.Count) failed=$bad"
if($bad){exit 47}
