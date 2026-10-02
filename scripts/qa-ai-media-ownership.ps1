$ErrorActionPreference='Stop'
$map=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'map-ai-media.ps1'))
$tx=[IO.File]::ReadAllText((Join-Path $PSScriptRoot 'gsc-ai-media-import.bat'))
$bad=0
$checks=[ordered]@{
 mapperNoTempBackup=($map -notmatch '\$backup|Copy-Item \$configPath')
 mapperRunsIntake=$map.Contains('qa-ai-media-intake.ps1')
 mapperWritesNoBom=$map.Contains('Text.UTF8Encoding($false)')
 transactionOwnsBackup=$tx.Contains('set "BAK=%TEMP%')
 transactionRollback=$tx.Contains('copy /y "%BAK%" "%CFG%"')
}
foreach($x in $checks.GetEnumerator()){Write-Host "MEDIA_OWNERSHIP $($x.Key)=$(if($x.Value){'PASS'}else{'FAIL'})";if(!$x.Value){$bad++}}
Write-Host "MEDIA_OWNERSHIP failed=$bad";if($bad){exit 68}
