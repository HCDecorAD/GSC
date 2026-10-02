$ErrorActionPreference='Stop'
$p=Join-Path $PSScriptRoot 'gsc-ai-media-import.bat'
$t=[IO.File]::ReadAllText($p)
$checks=[ordered]@{
 backup=$t.Contains('copy /y "%CFG%" "%BAK%"')
 backupRc=$t.Contains('set "BACKUP_RC=!ERRORLEVEL!"')
 backupFailFast=$t.Contains('AI MEDIA IMPORT BLOCKED - BACKUP FAILED')
 map=$t.Contains('map-ai-media.ps1')
 maprc=$t.Contains('set "MAP_RC=!ERRORLEVEL!"')
 gate=$t.Contains('gsc-ai-media-gate.bat')
 gaterc=$t.Contains('set "RC=!ERRORLEVEL!"')
 rollback=([regex]::Matches($t,'copy /y "%BAK%" "%CFG%"')).Count -ge 2
 commit=$t.Contains('AI MEDIA IMPORT COMMITTED')
}
$bad=0
foreach($x in $checks.GetEnumerator()){Write-Host "MEDIA_TX $($x.Key)=$(if($x.Value){'PASS'}else{'FAIL'})";if(!$x.Value){$bad++}}
Write-Host "MEDIA_TX failed=$bad"
if($bad){exit 66}
