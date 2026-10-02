$ErrorActionPreference='Stop'
$status=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-ai-media-status.bat'))
$bad=0
$required=@(
 'gsc-ai-media-manifest.json',
 'gsc-intro-assets.json',
 '.approved',
 '.scene_only',
 '.no_text_ui',
 'approved={0}/6',
 'mapped={1}/6',
 'complete={2}',
 'gsc-ai-media-gate.bat',
 'GATE_RC'
)
foreach($needle in $required){
 $ok=$status.Contains($needle)
 Write-Host "MEDIA_STATUS_V2 $needle $(if($ok){'PASS'}else{'FAIL'})"
 if(!$ok){$bad++}
}
$completeRule=$status.Contains('$approved -eq 6 -and $mapped -eq 6')
Write-Host "MEDIA_STATUS_V2 completenessRule=$(if($completeRule){'PASS'}else{'FAIL'})"
if(!$completeRule){$bad++}
Write-Host "MEDIA_STATUS_V2 failed=$bad"
if($bad){exit 73}
