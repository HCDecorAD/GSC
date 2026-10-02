$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
[xml]$xml=[IO.File]::ReadAllText((Join-Path $root 'sitemap.xml'))
$expected=@(
 'https://gscsenior.hcdecorhub.com/',
 'https://gscsenior.hcdecorhub.com/gsc-introduction.html',
 'https://gscsenior.hcdecorhub.com/project.html',
 'https://gscsenior.hcdecorhub.com/residences.html',
 'https://gscsenior.hcdecorhub.com/wellness.html',
 'https://gscsenior.hcdecorhub.com/lifestyle.html',
 'https://gscsenior.hcdecorhub.com/amenities.html',
 'https://gscsenior.hcdecorhub.com/location.html',
 'https://gscsenior.hcdecorhub.com/gallery.html',
 'https://gscsenior.hcdecorhub.com/insights.html',
 'https://gscsenior.hcdecorhub.com/contact.html'
)
$actual=@($xml.urlset.url | ForEach-Object {[string]$_.loc})
$missing=@($expected | Where-Object {$_ -notin $actual})
$extra=@($actual | Where-Object {$_ -notin $expected})
$duplicates=@($actual | Group-Object | Where-Object {$_.Count -gt 1})
$ok=($actual.Count -eq 11 -and $missing.Count -eq 0 -and $extra.Count -eq 0 -and $duplicates.Count -eq 0)
Write-Host "SITEMAP_QA count=$($actual.Count) missing=$($missing.Count) extra=$($extra.Count) duplicates=$($duplicates.Count) $(if($ok){'PASS'}else{'FAIL'})"
if(!$ok){exit 74}
