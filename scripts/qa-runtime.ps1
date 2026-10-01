$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$media=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-media.js'))
$app=[IO.File]::ReadAllText((Join-Path $root 'js\gsc-introduction.js'))
$config=[IO.File]::ReadAllText((Join-Path $root 'config\gsc-intro-assets.json'))
try{$cfg=$config|ConvertFrom-Json}catch{Write-Output 'RUNTIME_QA configJson=FAIL';exit 7}
$checks=[ordered]@{
intersectionObserver=($media -match 'IntersectionObserver')
reducedMotion=($media -match 'prefers-reduced-motion')
saveData=($media -match 'connection\.saveData')
imageError=($media -match 'img\.onerror')
videoError=($media -match "addEventListener\('error'")
configFetch=($app -match 'fetch\(url')
sameOrigin=($app -match "credentials: 'same-origin'")
hero=([bool]$cfg.assets.hero)
logo=([bool]$cfg.logo)
experience=($cfg.experience.Count -gt 0)
}
$failed=@($checks.GetEnumerator()|Where-Object{-not $_.Value})
"RUNTIME_QA total=$($checks.Count) failed=$($failed.Count)"
$failed|ForEach-Object{"FAILED $($_.Key)"}
if($failed.Count){exit 7}
