$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$m=Get-Content (Join-Path $root 'config/gsc-ai-media-manifest.json') -Raw | ConvertFrom-Json
$map=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'map-ai-media.ps1'))
$bad=0
$expected=@('seniorliving','healthcare','active','community','daily','location')

$versionOk=($m.version -eq 2)
$policyOk=([string]$m.policy).Trim().Length -gt 0
Write-Host "MANIFEST_V2 version=$(if($versionOk){'PASS'}else{'FAIL'}) value=$($m.version)"
Write-Host "MANIFEST_V2 policy=$(if($policyOk){'PASS'}else{'FAIL'})"
if(!$versionOk){$bad++}
if(!$policyOk){$bad++}

$actual=@($m.slots.PSObject.Properties.Name)
$missing=@($expected | Where-Object {$_ -notin $actual})
$extra=@($actual | Where-Object {$_ -notin $expected})
$slotSetOk=($missing.Count -eq 0 -and $extra.Count -eq 0 -and $actual.Count -eq 6)
Write-Host "MANIFEST_V2 slotSet=$(if($slotSetOk){'PASS'}else{'FAIL'}) count=$($actual.Count) missing=$($missing.Count) extra=$($extra.Count)"
if(!$slotSetOk){$bad++}

$paths=@()
foreach($slot in $expected){
 $prop=$m.slots.PSObject.Properties[$slot]
 if($null -eq $prop){continue}
 $meta=$prop.Value
 $path=[string]$meta.path
 $paths+=$path
 $shape=($null -ne $meta.path -and $null -ne $meta.scene_only -and $null -ne $meta.no_text_ui -and $null -ne $meta.approved)
 $expectedPath="assets/gsc-ai/$slot.jpg"
 $pathOk=($path -ceq $expectedPath)
 Write-Host "MANIFEST_V2 $slot shape=$(if($shape){'PASS'}else{'FAIL'}) path=$(if($pathOk){'PASS'}else{'FAIL'}) approved=$($meta.approved)"
 if(!$shape){$bad++}
 if(!$pathOk){$bad++}
}
$duplicatePaths=@($paths | Group-Object | Where-Object {$_.Count -gt 1})
$pathSetOk=($paths.Count -eq 6 -and $duplicatePaths.Count -eq 0)
Write-Host "MANIFEST_V2 pathSet=$(if($pathSetOk){'PASS'}else{'FAIL'}) duplicates=$($duplicatePaths.Count)"
if(!$pathSetOk){$bad++}

foreach($needle in @('$meta.path','$meta.approved','$meta.scene_only','$meta.no_text_ui')){
 $ok=$map.Contains($needle)
 Write-Host "MAPPER_V2 $needle $(if($ok){'PASS'}else{'FAIL'})"
 if(!$ok){$bad++}
}
Write-Host "MANIFEST_V2 failed=$bad"
if($bad){exit 70}
