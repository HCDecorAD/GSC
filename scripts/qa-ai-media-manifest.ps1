$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$m=Get-Content (Join-Path $root 'config/gsc-ai-media-manifest.json') -Raw|ConvertFrom-Json
$map=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'map-ai-media.ps1'))
$bad=0

$expected=@('seniorliving','healthcare','active','community','daily','location')
$actual=@($m.slots.PSObject.Properties.Name)
$missing=@($expected|Where-Object{$_ -notin $actual})
$extra=@($actual|Where-Object{$_ -notin $expected})
$paths=@($m.slots.PSObject.Properties|ForEach-Object{[string]$_.Value.path})
$duplicatePaths=@($paths|Group-Object|Where-Object{$_.Count -gt 1})
$slotSetOk=($missing.Count -eq 0 -and $extra.Count -eq 0 -and $actual.Count -eq 6)
$pathSetOk=($paths.Count -eq 6 -and $duplicatePaths.Count -eq 0 -and @($paths|Where-Object{$_ -notmatch '^assets/gsc-ai/[a-z]+\.jpg
 $meta=$p.Value
 $shape=($null -ne $meta.path -and $null -ne $meta.scene_only -and $null -ne $meta.no_text_ui -and $null -ne $meta.approved)
 Write-Host "MANIFEST_V2 $($p.Name) shape=$(if($shape){'PASS'}else{'FAIL'}) approved=$($meta.approved)"
 if(!$shape){$bad++}
}
foreach($needle in @('$meta.path','$meta.approved','$meta.scene_only','$meta.no_text_ui')){
 $ok=$map.Contains($needle);Write-Host "MAPPER_V2 $needle $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}
}
Write-Host "MANIFEST_V2 failed=$bad";if($bad){exit 70}
}).Count -eq 0)
Write-Host "MANIFEST_V2 slotSet=$(if($slotSetOk){'PASS'}else{'FAIL'}) count=$($actual.Count) missing=$($missing.Count) extra=$($extra.Count)"
Write-Host "MANIFEST_V2 pathSet=$(if($pathSetOk){'PASS'}else{'FAIL'}) duplicates=$($duplicatePaths.Count)"
if(!$slotSetOk){$bad++}
if(!$pathSetOk){$bad++}

foreach($p in $m.slots.PSObject.Properties){
 $meta=$p.Value
 $shape=($null -ne $meta.path -and $null -ne $meta.scene_only -and $null -ne $meta.no_text_ui -and $null -ne $meta.approved)
 Write-Host "MANIFEST_V2 $($p.Name) shape=$(if($shape){'PASS'}else{'FAIL'}) approved=$($meta.approved)"
 if(!$shape){$bad++}
}
foreach($needle in @('$meta.path','$meta.approved','$meta.scene_only','$meta.no_text_ui')){
 $ok=$map.Contains($needle);Write-Host "MAPPER_V2 $needle $(if($ok){'PASS'}else{'FAIL'})";if(!$ok){$bad++}
}
Write-Host "MANIFEST_V2 failed=$bad";if($bad){exit 70}
