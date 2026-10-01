$ErrorActionPreference='Stop'
$base='https://gscsenior.hcdecorhub.com'
$paths=@('/','/gsc-introduction.html','/css/gsc-introduction.css','/css/gsc-responsive.css','/js/gsc-introduction.js','/js/gsc-media.js','/config/gsc-intro-assets.json','/assets/gsc-web/gsc-logo-header.jpg','/assets/gsc-web/hero-blue-hour.png','/robots.txt','/sitemap.xml')
$failed=@()
foreach($p in $paths){
  try{
    $r=Invoke-WebRequest -UseBasicParsing -Uri ($base+$p) -Method Get -TimeoutSec 20
    $len=if($r.RawContentLength){$r.RawContentLength}else{$r.Content.Length}
    "PROD $($r.StatusCode) bytes=$len $p"
    if($r.StatusCode -ne 200 -or $len -lt 20){$failed+=$p}
  }catch{"PROD FAIL $p $($_.Exception.Message)";$failed+=$p}
}
"PROD_SMOKE total=$($paths.Count) failed=$($failed.Count)"
if($failed.Count){exit 40}
