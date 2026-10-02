$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pages=@('project.html','residences.html','wellness.html','lifestyle.html','amenities.html','location.html','gallery.html','insights.html','contact.html')
$bad=0
foreach($p in $pages){
 $t=[IO.File]::ReadAllText((Join-Path $root $p))
 $h1=([regex]::Matches($t,'<h1[ >]')).Count;$cta=([regex]::Matches($t,'class="seo-cta"')).Count
 $hero=[regex]::Match($t,"--hero:url\('(/assets/[^']+)'\)").Groups[1].Value
 $heroOk=$false;if($hero){$heroOk=Test-Path (Join-Path $root ($hero.TrimStart('/') -replace '/','\'))}
 $hrefs=[regex]::Matches($t,'href="([^"#?]+\.html)')|%{$_.Groups[1].Value}|?{$_ -notmatch '^https?://'}
 $broken=@();foreach($h in $hrefs){if(!(Test-Path (Join-Path $root ($h -replace '/','\')))){$broken+=$h}}
 $ok=($h1 -eq 1 -and $cta -eq 1 -and $heroOk -and $broken.Count -eq 0)
 "INTEGRITY $p h1=$h1 cta=$cta hero=$heroOk broken=$($broken.Count) $(if($ok){'PASS'}else{'FAIL'})"
 if(!$ok){$bad++}
}
"INTEGRITY total=$($pages.Count) failed=$bad";if($bad){exit 52}
