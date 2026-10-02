$ErrorActionPreference='Stop'
$release=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-website-release.bat'))
$required=@(
 'qa-ai-media-transaction.ps1',
 'qa-ai-media-mapping.ps1',
 'qa-ai-media-ownership.ps1',
 'qa-release-status.ps1',
 'qa-gate-wiring.ps1',
 'qa-release-execution.ps1'
)
$bad=0
foreach($name in $required){
  $count=([regex]::Matches($release,[regex]::Escape($name))).Count
  $ok=$count -ge 2
  Write-Host "RELEASE_EXECUTION $name occurrences=$count $(if($ok){'PASS'}else{'FAIL'})"
  if(!$ok){$bad++}
}
Write-Host "RELEASE_EXECUTION occurrenceFailed=$bad"

$sitePos=$release.IndexOf('call "%~dp0gsc-site-pages-gate.bat"')
foreach($name in $required){
  $execPos=$release.LastIndexOf($name)
  $ok=($sitePos -gt 0 -and $execPos -ge 0 -and $execPos -lt $sitePos)
  Write-Host "RELEASE_ORDER $name-before-site=$(if($ok){'PASS'}else{'FAIL'})"
  if(!$ok){$bad++}
}
if($bad){exit 69}
