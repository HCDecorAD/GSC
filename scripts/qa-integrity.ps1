$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$home=[IO.File]::ReadAllText((Join-Path $root 'index.html'))
$intro=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$cname=[IO.File]::ReadAllText((Join-Path $root 'CNAME')).Trim()
$robots=[IO.File]::ReadAllText((Join-Path $root 'robots.txt'))
$sitemap=[IO.File]::ReadAllText((Join-Path $root 'sitemap.xml'))
$notfound=[IO.File]::ReadAllText((Join-Path $root '404.html'))
$checks=[ordered]@{cname=($cname -ieq 'gscsenior.hcdecorhub.com');robots=($robots -match 'Sitemap:');sitemap=($sitemap -match 'gscsenior\.hcdecorhub\.com');notfound=($notfound -match 'index\.html');noPublicAdmin=(($intro -notmatch 'href="[^"]*admin') -and ($home -notmatch '>\s*Admin\s*<'));digitalTwin11=($home -match '11')}
$failed=@($checks.GetEnumerator()|Where-Object{-not $_.Value})
"INTEGRITY_QA total=$($checks.Count) failed=$($failed.Count)"
$failed|ForEach-Object{"FAILED $($_.Key)"}
if($failed.Count){exit 9}
