$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$required=@(
'assets\fonts\UTMAvo-Regular.ttf',
'assets\fonts\UTMAvo-Bold.ttf',
'assets\gsc-web\gsc-logo-header.jpg',
'assets\gsc-web\hero-blue-hour.png',
'assets\gsc-web\overview-aerial-day.png',
'assets\gsc-web\main-gate-koi.png',
'assets\gsc-web\wellness-pool.png',
'config\gsc-intro-assets.json',
'robots.txt','sitemap.xml','CNAME','404.html'
)
$missing=@($required|?{-not(Test-Path (Join-Path $root $_))})
"ASSET_QA required=$($required.Count) missing=$($missing.Count)"
$missing|%{"MISSING $_"}
if($missing.Count){exit 3}
