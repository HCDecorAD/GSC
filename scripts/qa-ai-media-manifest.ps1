$ErrorActionPreference='Stop'
$root=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$m=Get-Content (Join-Path $root 'config/gsc-ai-media-manifest.json') -Raw|ConvertFrom-Json
$map=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'map-ai-media.ps1'))
$bad=0
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
