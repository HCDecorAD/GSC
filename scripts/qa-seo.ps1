$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$html=[IO.File]::ReadAllText((Join-Path $root 'gsc-introduction.html'))
$checks=[ordered]@{
canonical=($html -match '<link rel="canonical" href="https://gscsenior\.hcdecorhub\.com/gsc-introduction\.html"')
robots=($html -match '<meta name="robots" content="index,follow,max-image-preview:large"')
ogTitle=($html -match 'property="og:title"')
ogImage=($html -match 'property="og:image"')
twitter=($html -match 'name="twitter:card" content="summary_large_image"')
jsonld=(([regex]::Matches($html,'application/ld\+json')).Count -eq 2)
}
$jsonBlocks=[regex]::Matches($html,'<script type="application/ld\+json">([\s\S]*?)</script>')
$jsonOK=$true
foreach($m in $jsonBlocks){try{$null=$m.Groups[1].Value|ConvertFrom-Json}catch{$jsonOK=$false}}
$checks['jsonValid']=$jsonOK
$failed=@($checks.GetEnumerator()|Where-Object{-not $_.Value})
"SEO_QA total=$($checks.Count) failed=$($failed.Count)"
$failed|ForEach-Object{"FAILED $($_.Key)"}
if($failed.Count){exit 6}
