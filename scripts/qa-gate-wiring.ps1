$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$release=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-website-release.bat'))
$site=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-site-pages-gate.bat'))
$releaseReq=@('qa-ai-media-mapping.ps1','qa-ai-media-manifest.ps1','qa-release-execution.ps1','qa-ai-media-ownership.ps1','qa-release-status.ps1','qa-ai-media-transaction.ps1','gsc-site-pages-gate.bat','gsc-ai-media-gate.bat','gsc-public-concept-gate.bat','qa-flagship.ps1','qa-responsive.ps1','gsc-public-evidence.bat')
$siteReq=@('gsc-seo-pages-gate.bat','gsc-site-architecture-gate.bat','qa-content-pages.ps1','qa-content-disclosures.ps1','qa-site-ux.ps1','qa-page-integrity.ps1','qa-social-meta.ps1','qa-pages-a11y.ps1','qa-performance-crawl.ps1','qa-schema-pages.ps1','qa-internal-links.ps1','qa-faq-pages.ps1','qa-site-pages.ps1')
$bad=0
foreach($x in $releaseReq){if(!$release.Contains($x)){Write-Host "RELEASE_WIRING FAIL $x";$bad++}else{Write-Host "RELEASE_WIRING PASS $x"}}
foreach($x in $siteReq){if(!$site.Contains($x)){Write-Host "SITE_WIRING FAIL $x";$bad++}else{Write-Host "SITE_WIRING PASS $x"}}
Write-Host "GATE_WIRING failed=$bad"

$posPublic=$release.IndexOf('gsc-public-evidence.bat')
$posMedia=$release.LastIndexOf('gsc-ai-media-gate.bat')
$orderOk=($posPublic -ge 0 -and $posMedia -gt $posPublic)
Write-Host "RELEASE_ORDER public-before-media=$(if($orderOk){'PASS'}else{'FAIL'})"
if(!$orderOk){$bad++}
if($bad){exit 62}
