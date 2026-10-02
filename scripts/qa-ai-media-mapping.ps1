$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$m=Get-Content (Join-Path $root 'config/gsc-ai-media-manifest.json') -Raw|ConvertFrom-Json
$c=Get-Content (Join-Path $root 'config/gsc-intro-assets.json') -Raw|ConvertFrom-Json
$bad=0;$mapped=0;$pending=0
foreach($p in $m.slots.PSObject.Properties){
 $slot=$p.Name;$expected=[string]$p.Value.path;$actual=[string]$c.assets.$slot
 if([string]::IsNullOrWhiteSpace($actual)){$pending++;Write-Host "MEDIA_MAPPING $slot PENDING expected=$expected";continue}
 $mapped++
 $ok=($actual -eq $expected)
 Write-Host "MEDIA_MAPPING $slot actual=$actual expected=$expected $(if($ok){'PASS'}else{'FAIL'})"
 if(!$ok){$bad++}
}
Write-Host "MEDIA_MAPPING consistencyFailed=$bad mapped=$mapped pending=$pending total=$($m.slots.PSObject.Properties.Count)"
if($bad -eq 0 -and $pending -gt 0){Write-Host "MEDIA_MAPPING CONSISTENCY_PASS COMPLETENESS_PENDING"}
if($bad -eq 0 -and $pending -eq 0){Write-Host "MEDIA_MAPPING CONSISTENCY_PASS COMPLETENESS_PASS"}
if($bad){exit 71}
